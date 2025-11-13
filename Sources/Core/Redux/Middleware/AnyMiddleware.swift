public struct AnyMiddleware<State, Action>: MiddlewareType {
    private let _process: (Action, Store<State, Action>, @escaping (Action) -> Void) -> Void
    
    public init<M: MiddlewareType>(_ middleware: M) where M.State == State, M.Action == Action {
        self._process = middleware.process
    }
    
    public init(_ process: @escaping (Action, Store<State, Action>, @escaping (Action) -> Void) -> Void) {
        self._process = process
    }
    
    public func process(action: Action, in store: Store<State, Action>, next: @escaping (Action) -> Void) {
        _process(action, store, next)
    }
}
