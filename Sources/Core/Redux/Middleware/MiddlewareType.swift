public protocol MiddlewareType {
    associatedtype State
    associatedtype Action
    
    func process(action: Action, in store: Store<State, Action>, next: @escaping (Action) -> Void)
}

extension MiddlewareType {
    public func eraseToAnyMiddleware() -> AnyMiddleware<State, Action> {
        return AnyMiddleware(self)
    }
}
