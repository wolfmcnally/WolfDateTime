import Foundation

public struct TimeZone: Codable {
    public let foundationTimeZone: Foundation.TimeZone

    public static let utc = TimeZone(secondsFromGMT: 0)!

    public var identifier: String {
        return foundationTimeZone.identifier
    }

    public init?(identifier: String) {
        guard let tz = Foundation.TimeZone(identifier: identifier) else { return nil }
        foundationTimeZone = tz
    }

    public init?(secondsFromGMT offset: Int) {
        guard let tz = Foundation.TimeZone(secondsFromGMT: offset) else {
            return nil
        }
        foundationTimeZone = tz
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let identifier = try container.decode(String.self)
        guard let tz = Foundation.TimeZone(identifier: identifier) else {
            throw WolfDateTimeError("Unknown time zone identifier: \(identifier).")
        }
        foundationTimeZone = tz
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(foundationTimeZone.identifier)
    }

    public func secondsFromGMT(for date: Date) -> Int {
        return foundationTimeZone.secondsFromGMT(for: date)
    }
}

extension TimeZone: CustomStringConvertible {
    public var description: String {
        return foundationTimeZone.description
    }
}

extension TimeZone: Equatable {
    public static func == (lhs: TimeZone, rhs: TimeZone) -> Bool {
        return lhs.foundationTimeZone == rhs.foundationTimeZone
    }
}
