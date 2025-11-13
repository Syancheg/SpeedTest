public struct ThunkMiddleware<State, Action>: MiddlewareType {
    public init() {}
    
    public func process(action: Action, in store: Store<State, Action>, next: @escaping (Action) -> Void) {
        if let thunk = action as? Thunk<State, Action> {
            thunk.body(store.send, { store.state })
        } else {
            next(action)
        }
    }
}
