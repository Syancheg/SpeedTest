import SwiftUI

struct AppRouter: View {
    @EnvironmentObject var store: Store<AppState, AppAction>
    
    var body: some View {
        Group {
            switch store.state.appLifecycle.currentScreen {
            case .main:
                MainView(state: store.state.mainState)
            }
        }
        .animation(.easeInOut, value: store.state.appLifecycle.currentScreen)
    }
}
