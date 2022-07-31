import XCTest
@testable import ElementTask

final class TrippleArgumentsParserTests: XCTestCase {
    func testParsedSuccessful() throws {
        let parser = TrippleArgumentsParser()
        XCTAssertEqual(
            try parser.arguments(from: "16 10 /path"),
            .init(hours: .value(10), minutes: .value(16), path: "/path")
        )
    }

    func testStarsParsed() throws {
        let parser = TrippleArgumentsParser()
        XCTAssertEqual(
            try parser.arguments(from: "* * /path"),
            .init(hours: .any, minutes: .any, path: "/path")
        )
    }

    func testZerosParsed() throws {
        let parser = TrippleArgumentsParser()
        XCTAssertEqual(
            try parser.arguments(from: "01 02 /path"),
            .init(hours: .value(2), minutes: .value(1), path: "/path")
        )
    }

    func testALotOfSpacesParsed() throws {
        let parser = TrippleArgumentsParser()
        XCTAssertEqual(
            try parser.arguments(from: "1     2    /path"),
            .init(hours: .value(2), minutes: .value(1), path: "/path")
        )
    }

    func testTabsParsed() throws {
        let parser = TrippleArgumentsParser()
        XCTAssertEqual(
            try parser.arguments(from: "1    2   /path"),
            .init(hours: .value(2), minutes: .value(1), path: "/path")
        )
    }

    func testTooLongArguments() throws {
        let parser = TrippleArgumentsParser()
        XCTAssertEqual(
            try parser.arguments(from: "101 111 /path"),
            .init(hours: .value(11), minutes: .value(1), path: "/path")
        )
    }

    func testRandomValueInsteadOfHour() throws {
        let parser = TrippleArgumentsParser()
        XCTAssertThrowsError(try parser.arguments(from: "1 A /path"), "") {
            XCTAssertTrue($0 as? TrippleArgumentsParser.InternalError == .hoursValue)
        }
    }

    func testRandomValueInsteadOfTime() throws {
        let parser = TrippleArgumentsParser()
        XCTAssertThrowsError(try parser.arguments(from: "A A /path"), "") {
            XCTAssertTrue($0 as? TrippleArgumentsParser.InternalError == .timeWasNotFound)
        }
    }

    func testPathIsMissed() throws {
        let parser = TrippleArgumentsParser()
        XCTAssertThrowsError(try parser.arguments(from: "15 16 "), "") {
            XCTAssertTrue($0 as? TrippleArgumentsParser.InternalError == .pathValue)
        }
    }

    func testTooManyHours() throws {
        let parser = TrippleArgumentsParser()
        XCTAssertThrowsError(try parser.arguments(from: "15 28 /path"), "") {
            XCTAssertTrue($0 as? TrippleArgumentsParser.InternalError == .hoursValue)
        }
    }

    func testTooManyMinutes() throws {
        let parser = TrippleArgumentsParser()
        XCTAssertThrowsError(try parser.arguments(from: "65 23 /path"), "") {
            XCTAssertTrue($0 as? TrippleArgumentsParser.InternalError == .minutesValue)
        }
    }
}
