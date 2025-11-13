public protocol APIClientType {
    func send<T: Decodable>(_ endpoint: any Endpoint) async throws -> T
}
