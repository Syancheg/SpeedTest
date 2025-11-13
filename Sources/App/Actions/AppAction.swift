enum AppAction: ActionType {
    case lifecycle(AppLifecycleAction)
    case main(MainAction)
}
