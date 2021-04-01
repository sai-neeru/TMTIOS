//
//  Child.swift
//  RedditDemo
//
//  Created by Sai Pavan Neerukonda on 3/31/21.
//
import Foundation

// MARK: - Child
struct Child: Codable {
    let kind: String
    let data: ChildData
}

// MARK: - ChildData
struct ChildData: Codable {
    let title: String
    let thumbnailHeight: Int?
    let thumbnailWidth: Int?
    let thumbnail: String
    let numComments: Int
    let score: Int

    enum CodingKeys: String, CodingKey {
        case title, thumbnail, score
        case thumbnailHeight = "thumbnail_height"
        case thumbnailWidth = "thumbnail_width"
        case numComments = "num_comments"
    }
}
