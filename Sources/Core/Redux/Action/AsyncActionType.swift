public protocol AsyncActionType: ActionType {
    associatedtype State
    func execute(dispatch: @escaping (ActionType) -> Void, getState: @escaping () -> State) -> Void
}
