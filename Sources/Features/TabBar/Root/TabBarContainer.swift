import SwiftUI

struct TabBarContainerView<Content: View>: View {
    @EnvironmentObject var store: Store<AppState, AppAction>
    let content: Content
    
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    private var tabBarState: TabBarState {
        store.state.tabBarState
    }
    
    var body: some View {
        ZStack(alignment: .bottom) {
            content
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            
            if !tabBarState.tabBarHidden {
                TabBarView()
                    .transition(.move(edge: .bottom))
            }
        }
        .ignoresSafeArea(.keyboard)
    }
}
