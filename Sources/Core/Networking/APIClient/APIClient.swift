import Foundation

public final class APIClient: APIClientType {
    public static let shared = APIClient()
    
    private let config: APIConfig
    private let session: URLSession
    private let middlewares: [RequestMiddlewareType]
    private let monitor: NetworkMonitorType?
    
    private let decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        decoder.dateDecodingStrategy = .iso8601
        return decoder
    }()
    
    public init(
        config: APIConfig = .development,
        session: URLSession = .shared,
        middlewares: [RequestMiddlewareType] = [],
        monitor: NetworkMonitorType? = nil
    ) {
        self.config = config
        self.session = session
        self.middlewares = middlewares
        self.monitor = monitor
    }
    
    public func send<T: Decodable>(_ endpoint: any Endpoint) async throws -> T {
        var request = try endpoint.makeRequest(with: config)
        
        for middleware in middlewares {
            request = middleware.prepare(request)
            middleware.beforeSend(request)
        }
        
        monitor?.requestDidStart(request)
        
        do {
            let (data, response) = try await session.data(for: request)
            
            for middleware in middlewares {
                middleware.didReceive(response, data: data, error: nil, for: request)
            }
            
            monitor?.requestDidComplete(request, response: response, data: data)
            
            try validateResponse(response, data: data)
            
            return try decoder.decode(T.self, from: data)
        } catch {
            for middleware in middlewares {
                middleware.didReceive(nil, data: nil, error: error, for: request)
            }
            
            monitor?.requestDidFail(request, error: error)
            throw mapError(error)
        }
    }
    
    private func validateResponse(_ response: URLResponse?, data: Data?) throws {
        guard let httpResponse = response as? HTTPURLResponse else {
            throw APIError.invalidResponse
        }
        
        switch httpResponse.statusCode {
        case 200...299:
            return
        case 401:
            throw APIError.unauthorized
        case 400...499:
            let message = extractErrorMessage(from: data)
            throw APIError.statusCode(httpResponse.statusCode, message)
        case 500...599:
            let message = extractErrorMessage(from: data)
            throw APIError.serverError(message ?? "Server error")
        default:
            throw APIError.unknown
        }
    }
    
    private func extractErrorMessage(from data: Data?) -> String? {
        guard let data = data,
              let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any] else {
            return nil
        }
        return json["message"] as? String ?? json["error"] as? String
    }
    
    private func mapError(_ error: Error) -> APIError {
        switch error {
        case let apiError as APIError:
            apiError
        case let urlError as URLError:
            switch urlError.code {
            case .notConnectedToInternet, .networkConnectionLost:
                    .noInternetConnection
            case .timedOut:
                    .timeout
            default:
                    .requestFailed(urlError)
            }
        case is DecodingError:
                .decodingFailed(error)
        default:
                .unknown
        }
    }
}

extension APIClient {
    public func sendWithResponse<T: Decodable>(_ endpoint: any Endpoint) async throws -> APIResponse<T> {
        try await send(endpoint)
    }
    
    public func sendData<T: APIEndpoint>(_ endpoint: T) async throws -> T.Response {
        let response: APIResponse<T.Response> = try await send(endpoint)
        guard let data = response.data else {
            throw APIError.invalidResponse
        }
        return data
    }
}
