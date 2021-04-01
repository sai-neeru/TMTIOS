//
//  IntRoundedAbbrevationTests.swift
//  RedditDemoTests
//
//  Created by Sai Pavan Neerukonda on 4/1/21.
//

import XCTest
@testable import RedditDemo


class IntRoundedAbbrevationTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testIntLessThanThousand() throws {
        let sut = 999
        XCTAssertEqual(sut.roundedWithAbbreviations, "999")
    }
    
    func testIntEqualToThousand() throws {
        let sut = 1000
        XCTAssertEqual(sut.roundedWithAbbreviations, "1.0K")
    }
    
    func testIntGreaterThanThousand() throws {
        let sut = 1001
        XCTAssertEqual(sut.roundedWithAbbreviations, "1.0K")
    }
    
    func testIntThousandRounding() throws {
        let sut = 1100
        XCTAssertEqual(sut.roundedWithAbbreviations, "1.1K")
    }

    func testIntLessThanMillion() throws {
        let sut = 999999
        XCTAssertEqual(sut.roundedWithAbbreviations, "1.0M")
    }
    
    func testIntEqualToMillion() throws {
        let sut = 1000000
        XCTAssertEqual(sut.roundedWithAbbreviations, "1.0M")
    }
    
    func testIntGreaterThanMillion() throws {
        let sut = 1000050
        XCTAssertEqual(sut.roundedWithAbbreviations, "1.0M")
    }
    
    func testIntMillionRounding() throws {
        let sut = 1100000
        XCTAssertEqual(sut.roundedWithAbbreviations, "1.1M")
    }
}
