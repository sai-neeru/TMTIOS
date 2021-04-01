//
//  RedditDemoTests.swift
//  RedditDemoTests
//
//  Created by Sai Pavan Neerukonda on 3/31/21.
//

import XCTest
@testable import RedditDemo

class FeedViewModelTests: XCTestCase {
    var sut: FeedViewModel?
    override func setUpWithError() throws {
        sut = FeedViewModel(service: FeedProvider(network: MockNetworking()))
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        sut = nil
    }

    func testFetchFeedSuccess() throws {
        sut?.fetchFeeds { (result) in
            switch result {
            case .success:
                XCTAssertEqual(self.sut?.cellModels.count, 1)
            case .failure(let error):
                XCTAssertNil(error)
            }
        }
    }
    
    func testMoreFetchFeedSuccess() throws {
        sut?.fetchFeeds { _ in }
        sut?.fetchFeeds { (result) in
            switch result {
            case .success:
                XCTAssertEqual(self.sut?.cellModels.count, 2)
            case .failure(let error):
                XCTAssertNil(error)
            }
        }
    }
    
    func testMoreFetchFeedError() throws {
        let errorNetwork = MockNetworking()
        let error = NSError(domain: "Testing", code: 17)
        sut = FeedViewModel(service: FeedProvider(network: errorNetwork))
        sut?.fetchFeeds { _ in }
        errorNetwork.error = error
        sut?.fetchFeeds { (result) in
            switch result {
            case .success:
                XCTAssertEqual(self.sut?.cellModels.count, 1)
            case .failure(let apiError):
                XCTAssertEqual(self.sut?.cellModels.count, 1)
                XCTAssertNotNil(apiError)
                XCTAssertEqual((apiError as NSError).code, 17)
            }
        }
    }

    func testPrepareCellModel() {
        XCTAssertEqual(self.sut?.cellModels.count, 0)
        sut?.prepareCellModels(newFeeds: [Child(kind: "tet", data: ChildData(title: "title", thumbnailHeight: 30, thumbnailWidth: 40, thumbnail: "http://Test.com", numComments: 20, score: 4))])
        XCTAssertEqual(self.sut?.cellModels.count, 1)
        XCTAssertEqual(self.sut?.cellModels.first?.title, "title")
        sut?.prepareCellModels(newFeeds: [Child(kind: "tet", data: ChildData(title: "title 3", thumbnailHeight: 30, thumbnailWidth: 40, thumbnail: "http://Test.com", numComments: 20, score: 4))])
        XCTAssertEqual(self.sut?.cellModels.count, 2)
        XCTAssertEqual(self.sut?.cellModels.last?.title, "title 3")
    }
}
