import Foundation

enum AppLifecycleAction {
    case appDidLaunch
    case appDidBecomeActive
    case appWillResignActive
    case navigateTo(AppScreen)
}
