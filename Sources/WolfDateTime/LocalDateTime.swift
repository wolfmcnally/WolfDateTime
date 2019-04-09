import Foundation

public struct LocalDateTime: Codable {
    private typealias `Self` = LocalDateTime

    public let string: String
    public let date: Date

    public static let formatter: DateFormatter = {
        let f = DateFormatter()
        f.locale = Locale(identifier: "en_US_POSIX")
        f.dateFormat = "yyyy-MM-dd HH:mm"
        f.timeZone = Foundation.TimeZone(secondsFromGMT: 0)
        return f
    }()

    public init(_ string: String) throws {
        self.string = string
        guard let date = Self.formatter.date(from: string) else {
            throw WolfDateTimeError("Invalid date-time format: \(string)")
        }
        self.date = date
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let string = try container.decode(String.self)
        try self.init(string)
    }

    public init(utcDateTime: UTCDateTime, in timeZone: TimeZone) {
        let offset = Double(timeZone.secondsFromGMT(for: utcDateTime))
        self.date = Date(timeIntervalSinceReferenceDate: utcDateTime.timeIntervalSinceReferenceDate + offset)
        string = Self.formatter.string(from: date)
    }

    public init(localDate: LocalDate, localTime: LocalTime, in timeZone: TimeZone) {
        date = localDate.toUTCDateTime(at: localTime, in: TimeZone.utc)
        string = Self.formatter.string(from: date)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(string)
    }

    public func toUTCDateTime(in timeZone: TimeZone) -> UTCDateTime {
        let offset = Double(timeZone.secondsFromGMT(for: date))
        return Date(timeIntervalSinceReferenceDate: date.timeIntervalSinceReferenceDate - offset)
    }

    public func localDate(in timeZone: TimeZone) -> LocalDate {
        return LocalDate(utcDateTime: toUTCDateTime(in: timeZone), in: timeZone)
    }

    public func localTime(in timeZone: TimeZone) -> LocalTime {
        return LocalTime(utcDateTime: toUTCDateTime(in: timeZone), in: timeZone)
    }
}

extension LocalDateTime: CustomStringConvertible {
    public var description: String {
        return string
    }
}

extension LocalDateTime: CustomDebugStringConvertible {
    public var debugDescription: String {
        return string
    }
}

extension LocalDateTime: ExpressibleByStringLiteral {
    public init(stringLiteral: String) {
        try! self.init(stringLiteral)
    }
}

extension LocalDateTime: Comparable {
    public static func == (lhs: LocalDateTime, rhs: LocalDateTime) -> Bool {
        return lhs.date == rhs.date
    }

    public static func < (lhs: LocalDateTime, rhs: LocalDateTime) -> Bool {
        return lhs.date < rhs.date
    }
}
