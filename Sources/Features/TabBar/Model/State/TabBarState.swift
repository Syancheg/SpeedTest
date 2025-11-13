struct TabBarState: Equatable {
    var selectedTab: TabBarTab = .main
    var tabBarHidden: Bool = false
    var tabBarItems: [TabBarItem] = [
        .main,
        .history,
        .profile,
        .settings
    ]
}
