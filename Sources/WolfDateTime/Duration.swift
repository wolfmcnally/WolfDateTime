import Foundation
import WolfCore

public struct Duration: Codable {
    public var timeInterval: TimeInterval

    public var formatted: String {
        let fractionalSeconds = fmod(timeInterval, oneSecond)
        var remainingSeconds = timeInterval - fractionalSeconds

        let seconds = fmod(remainingSeconds, oneMinute)
        remainingSeconds -= seconds

        let minutes = fmod(remainingSeconds / oneMinute, minutesPerHour)
        remainingSeconds -= minutes * oneMinute

        let hours = fmod(remainingSeconds / oneHour, hoursPerDay)
        remainingSeconds -= hours * oneHour

        let days = remainingSeconds / oneDay

        let daysString: String? = days > 0 ? "\(Int(days))d" : nil
        let hoursString: String? = hours > 0 ? "\(Int(hours))h" : nil
        let minutesString: String? = minutes > 0 ? "\(Int(minutes))m" : nil
        let secondsString: String? = seconds > 0 ? "\(Int(seconds))s" : nil

        return [
            daysString,
            hoursString,
            minutesString,
            secondsString
            ].compactMap({ $0 }).joined(separator: " ")
    }

    public init(_ timeInterval: TimeInterval) throws {
        guard timeInterval >= 0 else {
            throw WolfDateTimeError("Duration may not be negative.")
        }
        self.timeInterval = timeInterval
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        try self.init(container.decode(TimeInterval.self))
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(timeInterval)
    }
}

extension Duration: Comparable {
    public static func == (lhs: Duration, rhs: Duration) -> Bool {
        return lhs.timeInterval == rhs.timeInterval
    }

    public static func < (lhs: Duration, rhs: Duration) -> Bool {
        return lhs.timeInterval < rhs.timeInterval
    }
}
