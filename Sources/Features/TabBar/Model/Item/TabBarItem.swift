import Foundation

struct TabBarItem: Equatable, Identifiable {
    let id = UUID()
    let tab: TabBarTab
    let isEnabled: Bool
    
    static let main = TabBarItem(tab: .main, isEnabled: true)
    static let history = TabBarItem(tab: .history, isEnabled: true)
    static let profile = TabBarItem(tab: .profile, isEnabled: true)
    static let settings = TabBarItem(tab: .settings, isEnabled: true)
}
