enum MainAction: ActionType {
    case isLoading
    case isLoaded
    case failure(Error)
    case selectStart
    case result(MainResult)
    case retry
}
