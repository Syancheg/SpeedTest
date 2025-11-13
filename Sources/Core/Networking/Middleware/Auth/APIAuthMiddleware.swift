import Foundation

public struct APIAuthMiddleware: RequestMiddlewareType {
    private let tokenProvider: () -> String?
    
    public init(tokenProvider: @escaping () -> String?) {
        self.tokenProvider = tokenProvider
    }
    
    public func prepare(_ request: URLRequest) -> URLRequest {
        var modifiedRequest = request
        if let token = tokenProvider() {
            modifiedRequest.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }
        return modifiedRequest
    }
    
    public func beforeSend(_ request: URLRequest) {
        // Можно добавить логику перед отправкой
    }
    
    public func didReceive(_ response: URLResponse?, data: Data?, error: Error?, for request: URLRequest) {
        // Обработка ответов, например, обновление токена при 401
        if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 401 {
            // Триггер для обновления токена
        }
    }
}
