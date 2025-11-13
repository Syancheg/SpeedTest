import Foundation

func mainReducer(state: inout MainState, action: ActionType) -> Void {
    guard let action = action as? MainAction else {
        return
    }
    switch action {
    case .isLoading:
        state.isLoading = true
        state.error = nil
    case .isLoaded:
        state.isLoading = false
        state.error = nil
    case .failure(let error):
        state.isLoading = false
        state.error = error.localizedDescription
    case .selectStart:
        break
    case .result(let result):
        print(result)
        break
    case .retry:
        break
    }
}
