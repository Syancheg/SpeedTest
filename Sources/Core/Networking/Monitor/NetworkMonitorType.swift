import Foundation

public protocol NetworkMonitorType {
    func requestDidStart(_ request: URLRequest)
    func requestDidComplete(_ request: URLRequest, response: URLResponse, data: Data?)
    func requestDidFail(_ request: URLRequest, error: Error)
}
