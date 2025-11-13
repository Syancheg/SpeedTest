import Foundation

struct AppLifecycleState: Equatable {
    var currentScreen: AppScreen = .main
    var isActive: Bool = true
    var launchURL: URL?
}

enum AppScreen: Equatable {
    case main
}
