import Foundation

/// https://schema.org/DayOfWeek
public enum DayOfWeek: String, Codable {
    case sunday = "sun"     // 1 https://schema.org/Sunday
    case monday = "mon"     // 2 https://schema.org/Monday
    case tuesday = "tue"    // 3 https://schema.org/Tuesday
    case wednesday = "wed"  // 4 https://schema.org/Wednesday
    case thursday = "thu"   // 5 https://schema.org/Thursday
    case friday = "fri"     // 6 https://schema.org/Friday
    case saturday = "sat"   // 7 https://schema.org/Saturday

    public static let everyDay: Set<DayOfWeek> = [.sunday, .monday, .tuesday, .wednesday, .thursday, .friday, .saturday]
    
    public init?(dayNumber: Int) {
        switch dayNumber {
        case 1:
            self = .sunday
        case 2:
            self = .monday
        case 3:
            self = .tuesday
        case 4:
            self = .wednesday
        case 5:
            self = .thursday
        case 6:
            self = .friday
        case 7:
            self = .saturday
        default:
            return nil
        }
    }
    
    public var dayNumber: Int {
        switch self {
        case .sunday:
            return 1
        case .monday:
            return 2
        case .tuesday:
            return 3
        case .wednesday:
            return 4
        case .thursday:
            return 5
        case .friday:
            return 6
        case .saturday:
            return 7
        }
    }

    public var next: DayOfWeek {
        switch self {
        case .sunday:
            return .monday
        case .monday:
            return .tuesday
        case .tuesday:
            return .wednesday
        case .wednesday:
            return .thursday
        case .thursday:
            return .friday
        case .friday:
            return .saturday
        case .saturday:
            return .sunday
        }
    }
}

extension Calendar {
    public var firstDayOfWeek: DayOfWeek {
        switch firstWeekday {
        case 1:
            return .sunday
        case 2:
            return .monday
        case 3:
            return .tuesday
        case 4:
            return .wednesday
        case 5:
            return .thursday
        case 6:
            return .friday
        case 7:
            return .saturday
        default:
            fatalError()
        }
    }
}
