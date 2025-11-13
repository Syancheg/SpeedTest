import SwiftUI

struct TabBarView: View {
    @EnvironmentObject var store: Store<AppState, AppAction>
    
    private var tabBarState: TabBarState {
        store.state.tabBarState
    }
    
    var body: some View {
        TabView(selection: selectedTabBinding) {
            MainView()
                .tabItem { tabBarItem(for: .main) }
                .tag(TabBarTab.main)
        }
        .accentColor(.blue)
    }
    
    private var selectedTabBinding: Binding<TabBarTab> {
        Binding<TabBarTab>(
            get: { tabBarState.selectedTab },
            set: { newTab in
                store.send(.tabBar(.selectTab(newTab)))
            }
        )
    }
    
    @ViewBuilder
    private func tabBarItem(for tab: TabBarTab) -> some View {
        if let item = tabBarState.tabBarItems.first(where: { $0.tab == tab }) {
            VStack {
                Image(systemName: tabBarState.selectedTab == tab ?
                      tab.selectedIconName : tab.iconName)
                Text(tab.rawValue)
            }
            .opacity(item.isEnabled ? 1.0 : 0.5)
        }
    }
}
