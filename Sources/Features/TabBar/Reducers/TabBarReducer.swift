struct TabBarReducer: ReducerType {
    func reduce(state: inout TabBarState, action: TabBarAction) -> Void {
        switch action {
        case .selectTab(let tab):
            state.selectedTab = tab
        case .setTabBarHidden(let hidden):
            state.tabBarHidden = hidden
        case .updateTabBarItems(let items):
            state.tabBarItems = items
        case .enableTab(let tab):
            if let index = state.tabBarItems.firstIndex(where: { $0.tab == tab }) {
                state.tabBarItems[index] = TabBarItem(tab: tab, isEnabled: true)
            }
        case .disableTab(let tab):
            if let index = state.tabBarItems.firstIndex(where: { $0.tab == tab }) {
                state.tabBarItems[index] = TabBarItem(tab: tab, isEnabled: false)
            }
        }
    }
}
