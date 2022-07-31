import Foundation

// MARK: - LocalizedError
extension CLIFormatter.InternalError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .calendar:
            return "Oops, seems like there is an internal issue with calendar".localized
        }
    }
}
