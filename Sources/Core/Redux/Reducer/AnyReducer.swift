public struct AnyReducer<State, Action>: ReducerType {
    private let _reduce: (inout State, Action) -> Void
    
    public init<R: ReducerType>(_ reducer: R) where R.State == State, R.Action == Action {
        self._reduce = reducer.reduce
    }
    
    public init(_ reduce: @escaping (inout State, Action) -> Void) {
        self._reduce = reduce
    }
    
    public func reduce(state: inout State, action: Action) -> Void {
        _reduce(&state, action)
    }
}
