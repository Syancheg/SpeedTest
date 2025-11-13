import SwiftUI

struct AppRouter: View {
    @EnvironmentObject var store: Store<AppState, AppAction>
    
    var body: some View {
        TabBarContainerView {
            Group {
                switch store.state.tabBarState.selectedTab {
                case .main:
                    MainView()
                case .history:
                    EmptyView()
                case .profile:
                    EmptyView()
                case .settings:
                    EmptyView()
                }
            }
        }
    }
}
