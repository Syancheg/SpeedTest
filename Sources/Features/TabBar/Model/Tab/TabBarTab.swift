enum TabBarTab: String, CaseIterable, Equatable {
    case main = "Главная"
    case history = "История"
    case profile = "Профиль"
    case settings = "Настройки"
    
    var iconName: String {
        switch self {
        case .main:
            "house"
        case .history:
            "clock"
        case .profile:
            "person"
        case .settings:
            "gearshape"
        }
    }
    
    var selectedIconName: String {
        switch self {
        case .main:
            "house.fill"
        case .history:
            "clock.fill"
        case .profile:
            "person.fill"
        case .settings:
            "gearshape.fill"
        }
    }
}
