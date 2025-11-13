func appReducer(state: inout AppState, action: AppAction) -> Void {
    switch action {
    case .tabBar(let action):
        TabBarReducer().reduce(state: &state.tabBarState, action: action)
    case .main:
        mainReducer(state: &state.mainState, action: action)
    }
}
