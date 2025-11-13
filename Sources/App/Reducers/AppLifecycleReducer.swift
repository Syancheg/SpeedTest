struct AppLifecycleReducer: ReducerType {
    func reduce(state: inout AppLifecycleState, action: AppLifecycleAction) -> Void {
        switch action {
        case .appDidLaunch:
            state.currentScreen = .main
        case .navigateTo(let screen):
            state.currentScreen = screen
        case .appDidBecomeActive:
            state.isActive = true
        case .appWillResignActive:
            state.isActive = false
        }
    }
}
