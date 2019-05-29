import Foundation

public struct LocalDateSpan: Codable {
    public let start: LocalDate? // https://schema.org/validFrom
    public let end: LocalDate? // https://schema.org/validThrough

    public init(start: LocalDate?, end: LocalDate?) {
        self.start = start
        self.end = end
    }
}

extension LocalDateSpan: Equatable {
    public static func == (lhs: LocalDateSpan, rhs: LocalDateSpan) -> Bool {
        return lhs.start == rhs.start && lhs.end == rhs.end
    }
}

extension LocalDateSpan {
    public func localizedString(style: DateFormatter.Style = .short, rangeSeparator: String = "–") -> String? {
        let startString = start?.localizedString(style: style) ?? ""
        let endString = end?.localizedString(style: style) ?? ""
        guard startString != endString else { return startString }
        guard !startString.isEmpty || !endString.isEmpty else { return nil }
        return [startString, rangeSeparator, endString].compactMap({ $0 }).joined()
    }
}
