import SwiftUI

@main
struct SpeedTestApp: App {
    @StateObject private var store: Store<AppState, AppAction>
    @Environment(\.scenePhase) private var scenePhase
    
    init() {
        let state = AppState()
        
        let reducer = AnyReducer<AppState, AppAction> { state, action in
            appReducer(state: &state, action: action)
        }
        
        let middleware = CombinedMiddleware<AppState, AppAction>([
            LoggingMiddleware().eraseToAnyMiddleware(),
            ThunkMiddleware().eraseToAnyMiddleware()
        ])
        
        _store = StateObject(wrappedValue: Store<AppState, AppAction>(
            initialState: state,
            reducer: reducer,
            middleware: middleware.eraseToAnyMiddleware()
        ))
    }
    
    var body: some Scene {
        WindowGroup {
            AppRouter()
                .environmentObject(store)
                .onAppear {
                    store.send(.lifecycle(.appDidLaunch))
                }
        }
        .onChange(of: scenePhase) { _, newValue in
            handleScenePhaseChange(newValue)
        }
    }
    
    private func handleScenePhaseChange(_ scenePhase: ScenePhase) {
        switch scenePhase {
        case .active:
            store.send(.lifecycle(.appDidBecomeActive))
        case .inactive:
            store.send(.lifecycle(.appWillResignActive))
        case .background:
            break
        @unknown default:
            break
        }
    }
}
