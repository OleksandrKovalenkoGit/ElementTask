struct AppCore {
    let simulatedTimeFormatter: TimeFormatter
    let argumentsParser: ArgumentsParser
    let scheduler: CommandScheduler
    let outputFormatter: OutputFormatter
    let argumentsHandler: () -> [String]
}

extension AppCore {
    func run() {
        while let input = readLine() {
            do {
                let arguments = try argumentsParser.arguments(from: input)
                print(
                    try outputFormatter.format(
                        scheduledTime: scheduler.calculateExpectations(
                            from: try simulatedTimeFormatter.date(from: argumentsHandler().element(at: 1)),
                            arguments: try argumentsParser.arguments(from: input)
                        ),
                        path: arguments.path
                    )
                )
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}
