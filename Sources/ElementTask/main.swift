import Foundation

let mainApp = AppCore(
    simulatedTimeFormatter: SimulatedTimeFormatter(dateFormatter: DateFormatter()),
    argumentsParser: TrippleArgumentsParser(),
    scheduler: DailyCommandScheduler(calendar: Calendar.current),
    outputFormatter: CLIFormatter(dateFormatter: DateFormatter(), calendar: Calendar.current),
    argumentsHandler: { CommandLine.arguments }
)

mainApp.run()
