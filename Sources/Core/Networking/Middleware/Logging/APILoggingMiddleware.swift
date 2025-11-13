import Foundation

public struct APILoggingMiddleware: RequestMiddlewareType {
    private let logger: (String) -> Void
    
    public init(logger: @escaping (String) -> Void = { print($0) }) {
        self.logger = logger
    }
    
    public func prepare(_ request: URLRequest) -> URLRequest {
        logger("🌐 Request: \(request.httpMethod ?? "GET") \(request.url?.absoluteString ?? "")")
        if let headers = request.allHTTPHeaderFields {
            logger("📋 Headers: \(headers)")
        }
        if let body = request.httpBody, let bodyString = String(data: body, encoding: .utf8) {
            logger("📦 Body: \(bodyString)")
        }
        return request
    }
    
    public func beforeSend(_ request: URLRequest) {
        // Дополнительная логика перед отправкой
    }
    
    public func didReceive(_ response: URLResponse?, data: Data?, error: Error?, for request: URLRequest) {
        if let httpResponse = response as? HTTPURLResponse {
            let statusIcon = (200...299).contains(httpResponse.statusCode) ? "✅" : "❌"
            logger("\(statusIcon) Response: \(httpResponse.statusCode) \(request.url?.absoluteString ?? "")")
        }
        
        if let error = error {
            logger("💥 Error: \(error.localizedDescription)")
        }
        
        if let data = data, let dataString = String(data: data, encoding: .utf8) {
            logger("📥 Response Data: \(dataString)")
        }
    }
}
