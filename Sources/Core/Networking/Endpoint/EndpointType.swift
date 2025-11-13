import Foundation

public protocol Endpoint {
    var path: String { get }
    var method: HTTPMethod { get }
    var headers: [String: String]? { get }
    var parameters: [String: Any]? { get }
    var body: Data? { get }
    var queryItems: [URLQueryItem]? { get }
}

public extension Endpoint {
    var headers: [String: String]? { return nil }
    var parameters: [String: Any]? { return nil }
    var body: Data? { return nil }
    var queryItems: [URLQueryItem]? { return nil }
}

public enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
    case patch = "PATCH"
}

public protocol APIEndpoint: Endpoint {
    associatedtype Response: Decodable
}

extension Endpoint {
    func makeRequest(with config: APIConfig) throws -> URLRequest {
        var urlComponents = URLComponents(url: config.baseURL, resolvingAgainstBaseURL: true)!
        urlComponents.path += path
        
        if let queryItems = queryItems, !queryItems.isEmpty {
            urlComponents.queryItems = queryItems
        }
        
        guard let url = urlComponents.url else {
            throw APIError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.timeoutInterval = config.timeout
        
        var allHeaders = config.additionalHeaders
        headers?.forEach { allHeaders[$0.key] = $0.value }
        
        if method != .get, body != nil {
            allHeaders["Content-Type"] = "application/json"
        }
        
        request.allHTTPHeaderFields = allHeaders
        
        if let body = body {
            request.httpBody = body
        } else if let parameters = parameters, method != .get {
            request.httpBody = try? JSONSerialization.data(withJSONObject: parameters)
        }
        
        return request
    }
}
