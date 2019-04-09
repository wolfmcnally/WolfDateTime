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
