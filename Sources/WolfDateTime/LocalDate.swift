import Foundation

public struct LocalDate: Codable {
    private typealias `Self` = LocalDate

    public let string: String
    public let date: Date

    static let formatter: DateFormatter = {
        let f = DateFormatter()
        f.locale = Locale(identifier: "en_US_POSIX")
        f.dateFormat = "yyyy-MM-dd"
        f.timeZone = Foundation.TimeZone(secondsFromGMT: 0)
        return f
    }()

    public init(_ string: String) throws {
        self.string = string
        guard let date = Self.formatter.date(from: string) else {
            throw WolfDateTimeError("Invalid date format: \(string).")
        }
        self.date = date
    }

    private init(_ date: Date) {
        try! self.init(Self.formatter.string(from: date))
    }

    public init(year: Int, month: Int, day: Int) throws {
        let comps = DateComponents(calendar: Current.calendar, year: year, month: month, day: day)
        guard let date = comps.date else {
            throw WolfDateTimeError("Invalid date: \(year)-\(month)-\(day).")
        }
        self.init(date)
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let string = try container.decode(String.self)
        try self.init(string)
    }

    public init(utcDateTime: UTCDateTime, in timeZone: TimeZone) {
        let offset = Double(timeZone.secondsFromGMT(for: utcDateTime))
        let date = utcDateTime + offset
        self.init(date)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(string)
    }

    public func toUTCDateTime(at time: LocalTime, in timeZone: TimeZone) -> UTCDateTime {
        let date = self.date.addingTimeInterval(time.secondsSinceMidnight)
        let offset = Double(timeZone.secondsFromGMT(for: date))
        return Date(timeIntervalSinceReferenceDate: date.timeIntervalSinceReferenceDate - offset)
    }

    public var dayOfWeek: DayOfWeek {
        return DayOfWeek(dayNumber: Current.calendar.component(.weekday, from: date))!
    }

    public func adding(days: Int) -> LocalDate {
        let d = Current.calendar.date(byAdding: .day, value: days, to: date)!
        return LocalDate(d)
    }
}

extension LocalDate: CustomStringConvertible {
    public var description: String {
        return string
    }
}

extension LocalDate: CustomDebugStringConvertible {
    public var debugDescription: String {
        return string
    }
}

extension LocalDate: Comparable {
    public static func == (lhs: LocalDate, rhs: LocalDate) -> Bool {
        return lhs.date == rhs.date
    }

    public static func < (lhs: LocalDate, rhs: LocalDate) -> Bool {
        return lhs.date < rhs.date
    }
}

extension LocalDate: ExpressibleByStringLiteral {
    public init(stringLiteral: String) {
        try! self.init(stringLiteral)
    }
}
