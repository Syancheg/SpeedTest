import Foundation
import Combine

public final class Store<State, Action>: StoreType {
    
    @Published public private(set) var state: State
    
    private let reducer: AnyReducer<State, Action>
    private let middleware: AnyMiddleware<State, Action>?
    private let queue: DispatchQueue
    
    private var subscriptions: Set<AnyCancellable> = []
    
    public init(
        initialState: State,
        reducer: AnyReducer<State, Action>,
        middleware: AnyMiddleware<State, Action>? = nil,
        queue: DispatchQueue = DispatchQueue(label: "com.speedtest.redux.store", qos: .userInitiated)
    ) {
        self.state = initialState
        self.reducer = reducer
        self.middleware = middleware
        self.queue = queue
    }
    
    public func send(_ action: Action) {
        queue.async { [weak self] in
            self?.processAction(action)
        }
    }
    
    private func processAction(_ action: Action) {
        if let middleware = middleware {
            middleware.process(action: action, in: self) { [weak self] nextAction in
                self?.applyReducer(action: nextAction)
            }
        } else {
            applyReducer(action: action)
        }
    }
    
    private func applyReducer(action: Action) {
        var newState = state
        reducer.reduce(state: &newState, action: action)
        DispatchQueue.main.async { [weak self] in
            self?.state = newState
        }
    }
}
