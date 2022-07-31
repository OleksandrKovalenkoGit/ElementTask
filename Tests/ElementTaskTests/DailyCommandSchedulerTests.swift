import XCTest
@testable import ElementTask

final class DailyCommandSchedulerTests: XCTestCase {
    func testScheduledSuccessful() throws {
        XCTAssertEqual(
            prepareTime(for: 16, minutes: 0, desired: .init(hours: .value(16), minutes: .value(10), path: "/")),
            .init(hours: 16, minutes: 10, day: .today)
        )
    }

    func testScheduledSameTime() throws {
        XCTAssertEqual(
            prepareTime(for: 15, minutes: 0, desired: .init(hours: .value(15), minutes: .value(0), path: "/")),
            .init(hours: 15, minutes: 0, day: .today)
        )
    }

    func testScheduledToTheNextHourWithMinutes() throws {
        XCTAssertEqual(
            prepareTime(for: 15, minutes: 46, desired: .init(hours: .any, minutes: .value(45), path: "/")),
            .init(hours: 16, minutes: 45, day: .today)
        )
    }

    func testScheduledToTheBegginningOfTheNextDay() throws {
        XCTAssertEqual(
            prepareTime(for: 23, minutes: 46, desired: .init(hours: .any, minutes: .value(45), path: "/")),
            .init(hours: 0, minutes: 45, day: .tomorrow)
        )
    }

    func testScheduledToTheNextDayWithoutMinutes() throws {
        XCTAssertEqual(
            prepareTime(for: 15, minutes: 15, desired: .init(hours: .value(14), minutes: .any, path: "/")),
            .init(hours: 14, minutes: 0, day: .tomorrow)
        )
    }

    func testScheduledToTheNextDay() throws {
        XCTAssertEqual(
            prepareTime(for: 14, minutes: 31, desired: .init(hours: .value(14), minutes: .value(30), path: "/")),
            .init(hours: 14, minutes: 30, day: .tomorrow)
        )
    }

    func testScheduledToTheCurrentTime() throws {
        XCTAssertEqual(
            prepareTime(for: 14, minutes: 0, desired: .init(hours: .any, minutes: .any, path: "/")),
            .init(hours: 14, minutes: 0, day: .today)
        )
    }
}

private extension DailyCommandSchedulerTests {
    private func prepareTime(for hours: Int, minutes: Int, desired: CLIArguments) -> ScheduledTime {
        let scheduler = DailyCommandScheduler(
            calendar: CalendarMock(
                minutes: minutes,
                hours: hours,
                dateResponse: nil
            )
        )
        return scheduler.calculateExpectations(
            from: .init(),
            arguments: desired
        )
    }
}
