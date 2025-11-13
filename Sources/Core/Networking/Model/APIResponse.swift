import Foundation

public struct APIResponse<T: Decodable>: Decodable {
    public let data: T?
    public let message: String?
    public let status: String
}

public struct EmptyResponse: Decodable {}
