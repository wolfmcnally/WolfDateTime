import Foundation
public enum DayOfWeekRun {
    case singleDay(DayOfWeek)
    case runOfDays(DayOfWeek, DayOfWeek)

    public static func runs(for inputDays: Set<DayOfWeek>, calendar: Calendar = Current.calendar) -> [DayOfWeekRun] {
        let orderedDaysOfWeek: [DayOfWeek]
        switch calendar.firstDayOfWeek {
        case .sunday:
            orderedDaysOfWeek = [.sunday, .monday, .tuesday, .wednesday, .thursday, .friday, .saturday]
        case .monday:
            orderedDaysOfWeek = [.monday, .tuesday, .wednesday, .thursday, .friday, .saturday, .sunday]
        default:
            fatalError()
        }

        var result = [DayOfWeekRun]()

        var runStartIndex: Int?
        var runEndIndex: Int?

        func outputCurrentRun() {
            guard let startIndex = runStartIndex else { return }
            guard let endIndex = runEndIndex else {
                result.append(.singleDay(orderedDaysOfWeek[startIndex]))
                runStartIndex = nil
                return
            }
            result.append(.runOfDays(orderedDaysOfWeek[startIndex], orderedDaysOfWeek[endIndex]))
            runStartIndex = nil
            runEndIndex = nil
        }

        // Iterate through each week day once, in their canonical order
        for (index, day) in orderedDaysOfWeek.enumerated() {
            // If the input days contains the current day
            if inputDays.contains(day) {
                // If we're already accumulating a run
                if let startIndex = runStartIndex {
                    // If the run already has two or more elements in it
                    if let endIndex = runEndIndex {
                        // If the current day is consecutive from the end index
                        if index == endIndex + 1 {
                            // The current day becomes the end index
                            runEndIndex = index
                        } else {
                            // The current day is not consecutive from the end index
                            outputCurrentRun()

                            // Start a new run
                            runStartIndex = index
                        }
                    } else {
                        // If the current day is consecutive from the start index
                        if index == startIndex + 1 {
                            // This is the second element in the run
                            runEndIndex = index
                        } else {
                            // The current day is not consecutive from the start index
                            outputCurrentRun()

                            // Start a new run
                            runStartIndex = index
                        }
                    }
                } else {
                    // We're starting a new run
                    runStartIndex = index
                }
            } else {
                // The current day doesn't appear in the input days, so finish any run we were accumulating
                outputCurrentRun()
            }
        }
        // Finish any run we were accumulating
        outputCurrentRun()

        return result
    }
}
