func appReducer(state: inout AppState, action: AppAction) -> Void {
    switch action {
    case .lifecycle(let lifecycleAction):
            AppLifecycleReducer().reduce(state: &state.appLifecycle, action: lifecycleAction)
    case .main:
        mainReducer(state: &state.mainState, action: action)
    }
}
