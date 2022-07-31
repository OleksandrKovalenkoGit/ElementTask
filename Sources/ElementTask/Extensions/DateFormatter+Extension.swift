import Foundation

protocol DateFormatterProtocol: AnyObject {
    var dateFormat: String! { get set }

    func string(from date: Date) -> String
    func date(from string: String) -> Date?
}

// MARK: - DateFormatterProtocol
extension DateFormatter: DateFormatterProtocol {}
