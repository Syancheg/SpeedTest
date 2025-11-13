public struct Thunk<State, Action> {
    let body: (@escaping (Action) -> Void, @escaping () -> State) -> Void
    
    public init(_ body: @escaping (@escaping (Action) -> Void, @escaping () -> State) -> Void) {
        self.body = body
    }
}
