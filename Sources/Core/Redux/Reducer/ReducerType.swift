public protocol ReducerType {
    associatedtype State
    associatedtype Action
    
    func reduce(state: inout State, action: Action) -> Void
}

extension ReducerType {
    public func combined<R: ReducerType>(with other: R) -> CombinedReducer<State, Action>
    where R.State == State, R.Action == Action {
        CombinedReducer([
            AnyReducer(self),
            AnyReducer(other)
        ])
    }
    
    public func scope<GlobalState, GlobalAction>(
        _ keyPath: WritableKeyPath<GlobalState, State>,
        actionMap: @escaping (GlobalAction) -> Action?
    ) -> AnyReducer<GlobalState, GlobalAction> {
        AnyReducer<GlobalState, GlobalAction> { globalState, globalAction in
            
            guard let localAction = actionMap(globalAction) else {
                return
            }
            
            var localState = globalState[keyPath: keyPath]
            self.reduce(state: &localState, action: localAction)
            globalState[keyPath: keyPath] = localState
        }
    }
    
    public func optional() -> AnyReducer<State?, Action> {
        AnyReducer<State?, Action> { state, action in
            guard var nonOptionalState = state else { return }
            self.reduce(state: &nonOptionalState, action: action)
            state = nonOptionalState
        }
    }
    
    public func eraseToAnyReducer() -> AnyReducer<State, Action> {
        AnyReducer(self)
    }
}
