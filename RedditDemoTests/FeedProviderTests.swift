//
//  FeedProviderTests.swift
//  RedditDemoTests
//
//  Created by Sai Pavan Neerukonda on 4/1/21.
//

import XCTest
@testable import RedditDemo

class FeedProviderTestes: XCTestCase {
    var sut: FeedProvider!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        sut = nil
    }
    
    func testGetCartSuccess() {
        sut = FeedProvider(network: MockNetworking())
        sut.getFeed { (result) in
            switch result {
            case .success(let response):
                XCTAssertNotNil(response)
                XCTAssertNotNil(response.data)
            case .failure(let error):
                XCTAssertNil(error)
            }
        }
    }
    
    func testGetCartFailure() {
        let errorNetwork = MockNetworking()
        let error = NSError(domain: "Testing", code: 12)
        errorNetwork.error = error
        sut = FeedProvider(network: errorNetwork)
        sut.getFeed { (result) in
            switch result {
            case .success(let response):
                XCTAssertNil(response)
            case .failure(let error):
                XCTAssertNotNil(error)
                XCTAssertEqual((error as NSError).code, 12)
            }
        }
    }
}
