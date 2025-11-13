import Foundation

public struct APIConfig {
    let baseURL: URL
    let timeout: TimeInterval
    let apiKey: String?
    let additionalHeaders: [String: String]
    
    public init(
        baseURL: URL,
        timeout: TimeInterval = 30.0,
        apiKey: String? = nil,
        additionalHeaders: [String: String] = [:]
    ) {
        self.baseURL = baseURL
        self.timeout = timeout
        self.apiKey = apiKey
        self.additionalHeaders = additionalHeaders
    }
    
    public static let development = APIConfig(
        baseURL: URL(string: "https://api.dev.yourapp.com")!,
        timeout: 30.0
    )
    
    public static let production = APIConfig(
        baseURL: URL(string: "https://api.yourapp.com")!,
        timeout: 30.0
    )
}
