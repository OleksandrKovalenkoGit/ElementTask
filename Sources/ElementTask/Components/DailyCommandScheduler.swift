import Foundation

protocol CommandScheduler {
    func calculateExpectations(from date: Date, arguments: CLIArguments) -> ScheduledTime
}

struct DailyCommandScheduler {
    private enum Constants {
        static let hoursInADay = 24
    }

    let calendar: CalendarProtocol
}

// MARK: - CommandScheduler
extension DailyCommandScheduler: CommandScheduler {
    func calculateExpectations(from date: Date, arguments: CLIArguments) -> ScheduledTime {
        let simulatedMinutes = calendar.component(.minute, from: date)
        let simulatedHours = calendar.component(.hour, from: date)

        switch (arguments.hours, arguments.minutes) {
        // Checking cases for both hours and minutes specified
        // We need to consider several corner cases here like
        // a) If time is passed already by hours
        // b) Same, but for equal hours, so, we need to check minutes instead
        // c) If we can't do the command this day
        case let (.value(hours), .value(minutes)):
            let isTomorrow = hours < simulatedHours
                || (hours == simulatedHours && minutes < simulatedMinutes)
                || (hours == Constants.hoursInADay - 1 && minutes < simulatedMinutes)

            return .init(
                hours: hours,
                minutes: minutes,
                day: isTomorrow ? .tomorrow : .today
            )
        // Checking cases for specified minutes
        // Corner cases:
        // a) If we need to schedule a command for a next hour
        // b) If we need to schedule a command for a next day
        case let (.any, .value(minutes)):
            let hours = minutes < simulatedMinutes ? simulatedHours + 1 : simulatedHours
            let isTomorrow = hours == Constants.hoursInADay

            return .init(
                hours: isTomorrow ? 0 : hours,
                minutes: minutes,
                day: isTomorrow ? .tomorrow : .today
            )
        // Checking cases for specified hours
        // Corner cases:
        // a) We need to use current minutes for current hour or start from 0 for next one
        case let (.value(hours), .any):
            return .init(
                hours: hours,
                minutes: hours == simulatedHours ? simulatedMinutes : 0,
                day: hours < simulatedHours ? .tomorrow : .today
            )
        case (.any, .any):
            return .init(
                hours: simulatedHours,
                minutes: simulatedMinutes,
                day: .today
            )
        }
    }
}
