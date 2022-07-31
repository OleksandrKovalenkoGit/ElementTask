import Foundation

protocol TimeFormatter {
    func date(from input: String?) throws -> Date
}

struct SimulatedTimeFormatter {
    private enum Constants {
        static let defaultTimeFormat = "HH:mm"
    }

    enum InternalError: Error {
        case invalidDate
    }

    let dateFormatter: DateFormatterProtocol

    init(dateFormatter: DateFormatterProtocol, dateFormat: String = Constants.defaultTimeFormat) {
        self.dateFormatter = dateFormatter
        dateFormatter.dateFormat = dateFormat
    }
}

// MARK: - TimeFormatter
extension SimulatedTimeFormatter: TimeFormatter {
    func date(from input: String?) throws -> Date {
        if let input = input, let date = dateFormatter.date(from: input) {
            return date
        }
        throw InternalError.invalidDate
    }
}
