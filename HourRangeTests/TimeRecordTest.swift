//

import XCTest
@testable import HourRange

final class TimeRecordTests: XCTestCase {

    override func setUpWithError() throws { }

    override func tearDownWithError() throws { }

    func testIsContained() {
        let start: Hour = 6
        let end: Hour = 18
        XCTAssertTrue(TimeRecord(start: start, end: end, hour: 12).isContained)
        XCTAssertTrue(TimeRecord(start: start, end: end, hour: 6).isContained)
        XCTAssertTrue(TimeRecord(start: start, end: end, hour: 17).isContained)
    }
    
    func testIsNotContained() {
        let start: Hour = 6
        let end: Hour = 18
        XCTAssertFalse(TimeRecord(start: start, end: end, hour: 0).isContained)
        XCTAssertFalse(TimeRecord(start: start, end: end, hour: 5).isContained)
        XCTAssertFalse(TimeRecord(start: start, end: end, hour: 18).isContained)
    }
    
    func testIsContainedCrossDates() {
        let start: Hour = 22
        let end: Hour = 5
        XCTAssertTrue(TimeRecord(start: start, end: end, hour: 24).isContained)
        XCTAssertTrue(TimeRecord(start: start, end: end, hour: 22).isContained)
        XCTAssertTrue(TimeRecord(start: start, end: end, hour: 4).isContained)
    }
    
    func testIsNotContainedCrossDate() {
        let start: Hour = 22
        let end: Hour = 5
        XCTAssertFalse(TimeRecord(start: start, end: end, hour: 12).isContained)
        XCTAssertFalse(TimeRecord(start: start, end: end, hour: 21).isContained)
        XCTAssertFalse(TimeRecord(start: start, end: end, hour: 5).isContained)
    }
    
    func testSameHour() {
        XCTAssertTrue(TimeRecord(start: 0, end: 0, hour: 0).isContained)
    }
    
    func testIncludingAllHours() {
        XCTAssertTrue(TimeRecord(start: 0, end: 24, hour: 18).isContained)
    }
}
