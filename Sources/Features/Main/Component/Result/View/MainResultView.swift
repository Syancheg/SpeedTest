import SwiftUI

struct MainResultView: View {
    private let result: MainResult
    
    init(result: MainResult) {
        self.result = result
    }
    
    var body: some View {
        Rectangle()
            .frame(width: 100, height: 100, alignment: .bottom)
    }
}
