//
//  EndPointTests.swift
//  RedditDemoTests
//
//  Created by Sai Pavan Neerukonda on 4/1/21.
//

import XCTest
@testable import RedditDemo

class EndPointTests: XCTestCase {
    var sut: Endpoint?
    override func setUpWithError() throws {
        sut = .feed(nil)
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        sut = nil
    }

    func testPathWithNoAfterValue() throws {
        XCTAssertEqual(sut?.urlRequest.url?.absoluteString, Endpoint.feedBaseUrl)
    }
    
    func testPathWithAfterValue() throws {
        sut = .feed("Testing")
        XCTAssertEqual(sut?.urlRequest.url?.absoluteString, "\(Endpoint.feedBaseUrl)?after=Testing")
    }
}

