enum TabBarAction {
    case selectTab(TabBarTab)
    case setTabBarHidden(Bool)
    case updateTabBarItems([TabBarItem])
    case enableTab(TabBarTab)
    case disableTab(TabBarTab)
}
