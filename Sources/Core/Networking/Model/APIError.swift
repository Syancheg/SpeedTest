import Foundation

public enum APIError: Error, LocalizedError {
    case invalidURL
    case requestFailed(Error)
    case invalidResponse
    case statusCode(Int, String?)
    case decodingFailed(Error)
    case noInternetConnection
    case timeout
    case unauthorized
    case serverError(String)
    case unknown
    
    public var errorDescription: String? {
        switch self {
        case .invalidURL:
            "Invalid URL"
        case .requestFailed(let error):
            "Request failed: \(error.localizedDescription)"
        case .invalidResponse:
            "Invalid response from server"
        case .statusCode(let code, let message):
            "Error \(code): \(message ?? "Unknown error")"
        case .decodingFailed(let error):
            "Failed to decode response: \(error.localizedDescription)"
        case .noInternetConnection:
            "No internet connection"
        case .timeout:
            "Request timeout"
        case .unauthorized:
            "Unauthorized access"
        case .serverError(let message):
            "Server error: \(message)"
        case .unknown:
            "Unknown error occurred"
        }
    }
    
    public var statusCode: Int? {
        if case .statusCode(let code, _) = self {
            return code
        }
        return nil
    }
}
