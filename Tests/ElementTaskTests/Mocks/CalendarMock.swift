import Foundation
@testable import ElementTask

struct CalendarMock {
    let minutes: Int
    let hours: Int
    let dateResponse: Date?
}

// MARK: - CalendarProtocol
extension CalendarMock: CalendarProtocol {
    func component(_ component: Calendar.Component, from date: Date) -> Int {
        guard component == .minute else { return hours }
        return minutes
    }

    func date(bySettingHour hour: Int, minute: Int, of date: Date) -> Date? {
        dateResponse
    }
}
