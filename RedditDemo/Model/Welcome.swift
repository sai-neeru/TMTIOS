//
//  Welcome.swift
//  RedditDemo
//
//  Created by Sai Pavan Neerukonda on 3/31/21.
//

import Foundation

// MARK: - Welcome
struct Welcome: Codable {
    let kind: String
    let data: WelcomeData
}

// MARK: - WelcomeData
struct WelcomeData: Codable {
    let modhash: String
    let dist: Int
    let children: [Child]
    let after: String
}
