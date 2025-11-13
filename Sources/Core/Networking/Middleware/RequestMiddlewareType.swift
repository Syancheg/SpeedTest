import Foundation

public protocol RequestMiddlewareType {
    func prepare(_ request: URLRequest) -> URLRequest
    func beforeSend(_ request: URLRequest)
    func didReceive(_ response: URLResponse?, data: Data?, error: Error?, for request: URLRequest)
}
