import Foundation

protocol CalendarProtocol {
    func component(_ component: Calendar.Component, from date: Date) -> Int
    func date(bySettingHour hour: Int, minute: Int, of date: Date) -> Date?
}

// MARK: - CalendarProtocol
extension Calendar: CalendarProtocol {
    func date(bySettingHour hour: Int, minute: Int, of date: Date) -> Date? {
        self.date(bySettingHour: hour, minute: minute, second: .zero, of: date)
    }
}
