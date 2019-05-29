import Foundation

public func formatDaysOfWeek(_ daysOfWeek: Set<DayOfWeek>, symbolType: WeekdaySymbolType = .normal, calendar: Calendar = Current.calendar, rangeSeparator: String = "–", listSeparator: String = ",") -> String {
    let runs = DayOfWeekRun.runs(for: daysOfWeek, calendar: calendar)
    var runStrings = [String]()

    func formatDayOfWeek(_ dayOfWeek: DayOfWeek) -> String {
        return calendar.weekdayName(for: dayOfWeek, symbolType: symbolType)
    }

    for run in runs {
        switch run {
        case .singleDay(let day):
            runStrings.append(formatDayOfWeek(day))
        case .runOfDays(let firstDay, let lastDay):
            runStrings.append(formatDayOfWeek(firstDay) + rangeSeparator + formatDayOfWeek(lastDay))
        }
    }

    return runStrings.joined(separator: listSeparator)
}
