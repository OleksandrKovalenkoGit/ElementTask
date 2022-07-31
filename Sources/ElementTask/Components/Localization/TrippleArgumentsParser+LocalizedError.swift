import Foundation

// MARK: - LocalizedError
extension TrippleArgumentsParser.InternalError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .timeFormat:
            return "Oops, seems like there is an issue with time forma".localized
        case .timeWasNotFound:
            return "Oops, seems like time cannot be found".localized
        case .pathFormat:
            return "Oops, seems like there is an issue with path format".localized
        case .minutesValue:
            return "Oops, seems like minutes cannot be parsed properly".localized
        case .hoursValue:
            return "Oops, seems like hours cannot be parsed properly".localized
        case .pathValue:
            return "Oops, seems like the path cannot be parsed properly".localized
        }
    }
}
