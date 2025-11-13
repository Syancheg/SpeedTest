import Foundation

public struct LoggingMiddleware<State, Action>: MiddlewareType {
    private let logger: (String) -> Void
    
    public init(logger: @escaping (String) -> Void = { print($0) }) {
        self.logger = logger
    }
    
    public func process(action: Action, in store: Store<State, Action>, next: @escaping (Action) -> Void) {
        logger("🔸 Action: \(action)")
        logger("📊 State before: \(store.state)")
        
        next(action)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.logger("📈 State after: \(store.state)")
        }
    }
}
