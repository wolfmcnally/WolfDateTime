import Foundation
import WolfCore

/// https://schema.org/Time
public struct LocalTime: Codable {
    private typealias `Self` = LocalTime

    public static let midnight = LocalTime("00:00")

    public let string: String
    public let date: Date

    public static let formatter: DateFormatter = {
        let f = DateFormatter()
        f.locale = Locale(identifier: "en_US_POSIX")
        f.dateFormat = "HH:mm"
        f.timeZone = Foundation.TimeZone(secondsFromGMT: 0)
        f.defaultDate = Date(timeIntervalSinceReferenceDate: 0)
        return f
    }()

    public init(_ string: String) throws {
        self.string = string
        guard let date = Self.formatter.date(from: string) else {
            throw WolfDateTimeError("Invalid time format: \(string)")
        }
        self.date = date
    }

    public init(hour: Int, minute: Int) throws {
        guard (0...23).contains(hour) else {
            throw WolfDateTimeError("Invalid hour: \(hour)")
        }

        guard (0...59).contains(minute) else {
            throw WolfDateTimeError("Invalid minute: \(minute)")
        }

        let components = DateComponents(year: 2001, hour: hour, minute: minute)
        date = Current.calendar.date(from: components)!
        string = Self.formatter.string(from: date)
    }

    public init(secondsSinceMidnight: TimeInterval) {
        let seconds = Int(secondsSinceMidnight.truncatingRemainder(dividingBy: oneDay))
        let components = DateComponents(year: 2001, second: seconds)
        date = Current.calendar.date(from: components)!
        string = Self.formatter.string(from: date)
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let string = try container.decode(String.self)
        try self.init(string)
    }

    private init(_ date: Date) {
        try! self.init(Self.formatter.string(from: date))
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

    public var secondsSinceMidnight: TimeInterval {
        return date.timeIntervalSinceReferenceDate
    }

    public func toUTCDateTime(on date: LocalDate, in timeZone: TimeZone) -> UTCDateTime {
        return date.toUTCDateTime(at: self, in: timeZone)
    }

    public func adding(hours: Int = 0, minutes: Int = 0) -> LocalTime {
        let offset = secondsSinceMidnight + oneHour * Double(hours) + oneMinute * Double(minutes)
        return LocalTime(secondsSinceMidnight: offset)
    }
}

extension LocalTime: CustomStringConvertible {
    public var description: String {
        return string
    }
}

extension LocalTime: CustomDebugStringConvertible {
    public var debugDescription: String {
        return string
    }
}

extension LocalTime: Comparable {
    public static func == (lhs: LocalTime, rhs: LocalTime) -> Bool {
        return lhs.date == rhs.date
    }

    public static func < (lhs: LocalTime, rhs: LocalTime) -> Bool {
        return lhs.date < rhs.date
    }
}

extension LocalTime: ExpressibleByStringLiteral {
    public init(stringLiteral: String) {
        try! self.init(stringLiteral)
    }
}

extension LocalTime {
    public func localizedString(locale: Locale = .current, style: DateFormatter.Style = .short) -> String {
        let formatter = DateFormatter() • {
            $0.locale = locale
            $0.dateStyle = .none
            $0.timeStyle = style
            $0.timeZone = Foundation.TimeZone(secondsFromGMT: 0)
            $0.defaultDate = Date(timeIntervalSinceReferenceDate: 0)
        }
        return formatter.string(from: date)
    }
}
