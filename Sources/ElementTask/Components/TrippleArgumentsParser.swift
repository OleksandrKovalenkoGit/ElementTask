import Foundation

protocol ArgumentsParser {
    func arguments(from input: String) throws -> CLIArguments
}

struct TrippleArgumentsParser {
    private enum Formats {
        static let timeArguments = "([0-9][0-9]?|\\*)\\s"
        static let path = "\\s(\\S).*"
    }

    private enum Constants {
        static let maxMinutes = 59
        static let maxHours = 23
    }

    enum InternalError: Error {
        case timeFormat
        case timeWasNotFound
        case pathFormat
        case minutesValue
        case hoursValue
        case pathValue
    }
}

// MARK: - ArgumentsParser
extension TrippleArgumentsParser: ArgumentsParser {
    func arguments(from input: String) throws -> CLIArguments {
        guard let timeArgument = try? input.regexMatches(for: Formats.timeArguments) else {
            throw InternalError.timeFormat
        }
        guard let timeLastIndex = timeArgument.lastIndex else {
            throw InternalError.timeWasNotFound
        }
        guard let pathArgument = try? input.regexMatches(for: Formats.path, from: timeLastIndex) else {
            throw InternalError.pathFormat
        }
        guard let minutes = timeArgument.matches.first?.toTimeValue(maxValue: Constants.maxMinutes) else {
            throw InternalError.minutesValue
        }
        guard let hours = timeArgument.matches.element(at: 1)?.toTimeValue(maxValue: Constants.maxHours) else {
            throw InternalError.hoursValue
        }
        guard let path = pathArgument.matches.first?.dropFirst() else {
            throw InternalError.pathValue
        }
        return .init( hours: hours, minutes: minutes, path: String(path))
    }
}

private extension String {
    func toTimeValue(minValue: Int = .zero, maxValue: Int) -> CronTime? {
        if contains("*") { return .any }

        guard let value = Int(replacingOccurrences(of: " ", with: "")) else { return nil }

        return value >= minValue && value <= maxValue ? .value(value) : nil
    }
}
