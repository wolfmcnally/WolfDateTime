import Foundation
import WolfCore

public struct TimeSpan: Codable {
    public var start: UTCDateTime // https://schema.org/startDate
    public var end: UTCDateTime // https://schema.org/endDate
    public var duration: Duration // https://pending.schema.org/duration

    public init(start: UTCDateTime, end: UTCDateTime) throws {
        self.start = start
        self.end = end
        self.duration = try Duration(end.timeIntervalSinceReferenceDate - start.timeIntervalSinceReferenceDate)
    }

    public init(start: UTCDateTime, duration: Duration) throws {
        try self.init(start: start, end: UTCDateTime(timeIntervalSinceReferenceDate: start.timeIntervalSinceReferenceDate + duration.timeInterval))
    }

    enum CodingKeys: String, CodingKey {
        case start
        case end
        case duration
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let start = try container.decode(UTCDateTime.self, forKey: .start)
        if let end = try container.decodeIfPresent(UTCDateTime.self, forKey: .end) {
            try self.init(start: start, end: end)
        } else {
            let duration = try container.decode(Duration.self, forKey: .duration)
            try self.init(start: start, duration: duration)
        }
    }

    public func contains(date: UTCDateTime) -> Bool {
        return date >= start && date <= end
    }
}

extension TimeSpan {
    public func description(in timeZone: TimeZone) -> String {
        let a = LocalDateTime(utcDateTime: start, in: timeZone)
        let b = LocalDateTime(utcDateTime: end, in: timeZone)
        return("\(a)–\(b)")
    }

    public func descriptionTimeOnly(in timeZone: TimeZone) -> String {
        let a = LocalTime(utcDateTime: start, in: timeZone)
        let b = LocalTime(utcDateTime: end, in: timeZone)
        return("\(a)–\(b)")
    }
}
