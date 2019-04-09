import Foundation
import WolfCore

public protocol GlobalProtocol {
    var date: Date { get }
    @available(iOS 10.0, tvOS 10.0, OSX 10.12, *)
    var dateFormatter: ISO8601DateFormatter { get }
    var calendar: Calendar { get }
}

public class Global: GlobalProtocol {
    public var date: Date { return Date() }

    @available(iOS 10.0, tvOS 10.0, OSX 10.12, *)
    public lazy var dateFormatter: ISO8601DateFormatter = .init() |> {
        $0.formatOptions = .withInternetDateTime
    }

    public let calendar: Calendar = {
        var calendar = Calendar(identifier: .gregorian)
        calendar.timeZone = Foundation.TimeZone(secondsFromGMT: 0)!
        return calendar
    }()
}

public let Current: GlobalProtocol = Global()
