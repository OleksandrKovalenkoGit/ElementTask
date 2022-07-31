import Foundation

// MARK: - LocalizedError
extension SimulatedTimeFormatter.InternalError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .invalidDate:
            return "Oops, seems like the simulated time was added incorrectly.".localized
        }
    }
}
