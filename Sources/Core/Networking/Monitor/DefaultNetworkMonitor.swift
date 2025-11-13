import Foundation

public class DefaultNetworkMonitor: NetworkMonitorType {
    private let logger: (String) -> Void
    
    public init(logger: @escaping (String) -> Void = { print($0) }) {
        self.logger = logger
    }
    
    public func requestDidStart(_ request: URLRequest) {
        logger("🚀 Starting request: \(request.httpMethod ?? "GET") \(request.url?.absoluteString ?? "")")
    }
    
    public func requestDidComplete(_ request: URLRequest, response: URLResponse, data: Data?) {
        let httpResponse = response as? HTTPURLResponse
        let statusCode = httpResponse?.statusCode ?? 0
        let size = data?.count ?? 0
        
        logger("✅ Request completed: \(statusCode) - \(size) bytes")
    }
    
    public func requestDidFail(_ request: URLRequest, error: Error) {
        logger("💥 Request failed: \(error.localizedDescription)")
    }
}
