import Foundation

public enum WeekdaySymbolType {
    case normal
    case short
    case veryShort
    case standalone
    case shortStandalone
    case veryShortStandalone
}

extension Calendar {
    public func weekdaySymbols(for symbolType: WeekdaySymbolType) -> [String] {
        switch symbolType {
        case .normal:
            return weekdaySymbols
        case .short:
            return shortWeekdaySymbols
        case .veryShort:
            return veryShortWeekdaySymbols
        case .standalone:
            return standaloneWeekdaySymbols
        case .shortStandalone:
            return shortStandaloneWeekdaySymbols
        case .veryShortStandalone:
            return veryShortStandaloneWeekdaySymbols
        }
    }

    public func weekdayName(for dayOfWeek: DayOfWeek, symbolType: WeekdaySymbolType = .normal) -> String {
        let symbols = weekdaySymbols(for: symbolType)
        return symbols[dayOfWeek.dayNumber - 1]
    }
}
