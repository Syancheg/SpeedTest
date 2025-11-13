import SwiftUI

struct MainView: View {
    @EnvironmentObject var store: Store<AppState, AppAction>
    
    var body: some View {
        switch store.state.mainState.screen {
        case .start:
            MainStartView()
        case .process:
            MainProcessView()
        case .result(let result):
            MainResultView(
                result: result
            )
        }
    }
}
