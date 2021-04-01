//
//  FeedCellViewModel.swift
//  RedditDemo
//
//  Created by Sai Pavan Neerukonda on 3/31/21.
//

import Foundation

class FeedCellViewModel {
    let title: String
    let score: String
    let comments: String
    let imageURL: String
    let imageHeight: Int?
    let imageWidth: Int?
    let feed: ChildData
    
    init(child: Child) {
        feed = child.data
        title = feed.title
        score = feed.score.roundedWithAbbreviations
        comments = feed.numComments.roundedWithAbbreviations
        imageURL = feed.thumbnail
        imageWidth = feed.thumbnailWidth
        imageHeight = feed.thumbnailHeight
    }
}

