import Foundation

protocol OutputFormatter {
    func format(scheduledTime: ScheduledTime, path: String) throws -> String
}

struct CLIFormatter {
    private enum Formats {
        static let time = "H:mm"
        static let print = "%@ %@ - %@"
    }

    let dateFormatter: DateFormatterProtocol
    let calendar: CalendarProtocol
    let printFormat: String

    enum InternalError: Error {
        case calendar
    }

    init(
        dateFormatter: DateFormatterProtocol,
        calendar: CalendarProtocol,
        timeFormat: String = Formats.time,
        printFormat: String = Formats.print
    ) {
        self.dateFormatter = dateFormatter
        self.calendar = calendar
        self.printFormat = printFormat

        dateFormatter.dateFormat = timeFormat
    }
}

// MARK: - OutputFormatter
extension CLIFormatter: OutputFormatter {
    func format(scheduledTime: ScheduledTime, path: String) throws -> String {
        guard let expectedDate = calendar.date(
            bySettingHour: scheduledTime.hours, minute: scheduledTime.minutes, of: .init()
        ) else {
            throw InternalError.calendar
        }
        return .init(
            format: printFormat,
            arguments: [dateFormatter.string(from: expectedDate), scheduledTime.day.rawValue, path]
        )
    }
}
