//
//  FeedCellViewModelTests.swift
//  RedditDemoTests
//
//  Created by Sai Pavan Neerukonda on 4/1/21.
//

import XCTest
@testable import RedditDemo

class FeedCellViewModelTests: XCTestCase {
    var sut: FeedCellViewModel!
    let child = Child(kind: "tet", data: ChildData(title: "title", thumbnailHeight: 30, thumbnailWidth: 40, thumbnail: "http://Test.com", numComments: 20, score: 4))
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        sut = nil
    }

    func testTitle() throws {
        sut = FeedCellViewModel(child: child)
        
        XCTAssertEqual(sut.title, child.data.title)
    }
    
    func testImageUrl() throws {
        sut = FeedCellViewModel(child: child)
        
        XCTAssertEqual(sut.imageURL, child.data.thumbnail)
    }
    
    func testImageWidth() throws {
        sut = FeedCellViewModel(child: child)
        
        XCTAssertEqual(sut.imageWidth, child.data.thumbnailWidth)
    }
    
    func testImageHeight() throws {
       
        sut = FeedCellViewModel(child: child)
        
        XCTAssertEqual(sut.imageHeight, child.data.thumbnailHeight)
    }
    
    func testComments() throws {
       
        sut = FeedCellViewModel(child: child)
        
        XCTAssertEqual(sut.comments, child.data.numComments.roundedWithAbbreviations)
    }
    
    func testScore() throws {
       
        sut = FeedCellViewModel(child: child)
        
        XCTAssertEqual(sut.score, child.data.score.roundedWithAbbreviations)
    }
}
