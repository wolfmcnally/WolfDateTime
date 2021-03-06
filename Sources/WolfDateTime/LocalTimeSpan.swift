import Foundation

public struct LocalTimeSpan: Codable {
    public let start: LocalTime // https://schema.org/opens
    public let end: LocalTime  // https://schema.org/closes

    public init(start: LocalTime, end: LocalTime) {
        self.start = start
        self.end = end
    }
}

extension LocalTimeSpan: Equatable {
    public static func == (lhs: LocalTimeSpan, rhs: LocalTimeSpan) -> Bool {
        return lhs.start == rhs.start && lhs.end == rhs.end
    }
}

extension LocalTimeSpan {
    public func localizedString(style: DateFormatter.Style = .short, rangeSeparator: String = "–") -> String {
        let startString = start.localizedString(style: style)
        let endString = end.localizedString(style: style)
        return startString + rangeSeparator + endString
    }
}
