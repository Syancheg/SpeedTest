import SwiftUI

struct MainView: View {
    @StateObject private var store: Store<MainState, MainAction>
    
    init(state: MainState) {
        let reducer = AnyReducer<MainState, MainAction> { state, action in
            mainReducer(state: &state, action: action)
        }
        
        _store = StateObject(wrappedValue: Store<MainState, MainAction>(
            initialState: state,
            reducer: reducer
        ))
    }
    
    var body: some View {
        switch store.state.screen {
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
