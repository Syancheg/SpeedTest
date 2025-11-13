struct MainResult: Equatable {
    let value: Double
    let unit: TestUnit
}

enum TestUnit {
    case megabit
    case gigabit
    case kilobit
    case millisecond
    case second
    
    var title: String {
        switch self {
        case .megabit:
            "mb/s"
        case .gigabit:
            "gb/s"
        case .kilobit:
            "kb/s"
        case .millisecond:
            "ms"
        case .second:
            "s"
        }
    }
}
