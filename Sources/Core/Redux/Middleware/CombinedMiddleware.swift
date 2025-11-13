public struct CombinedMiddleware<State, Action>: MiddlewareType {
    private let middlewares: [AnyMiddleware<State, Action>]
    
    public init(_ middlewares: [AnyMiddleware<State, Action>]) {
        self.middlewares = middlewares
    }
    
    public func process(action: Action, in store: Store<State, Action>, next: @escaping (Action) -> Void) {
        func processNext(_ index: Int, _ currentAction: Action) {
            if index < middlewares.count {
                let middleware = middlewares[index]
                middleware.process(action: currentAction, in: store) { nextAction in
                    processNext(index + 1, nextAction)
                }
            } else {
                next(currentAction)
            }
        }
        
        processNext(0, action)
    }
}
