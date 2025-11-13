public struct CombinedReducer<State, Action>: ReducerType {
    private let reducers: [AnyReducer<State, Action>]
    
    public init(_ reducers: [AnyReducer<State, Action>]) {
        self.reducers = reducers
    }
    
    public func reduce(state: inout State, action: Action) -> Void {
        reducers.forEach { reducer in
            reducer.reduce(state: &state, action: action)
        }
    }
}
