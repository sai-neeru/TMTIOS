//
//  Endpoint.swift
//  WagzDemo
//
//
//  Endpoint.swift
//  RedditDemo
//
//  Created by Sai Pavan Neerukonda on 4/1/21.
//
import Foundation

protocol RequestProviding {
    var urlRequest: URLRequest { get }
    var mockPath: String { get }
}

enum Endpoint {
    static let feedBaseUrl = "https://www.reddit.com/.json"
    case feed(String?)
}

extension Endpoint: RequestProviding {
    var urlRequest: URLRequest {
        switch self {
        case .feed(let after):
            var path = Endpoint.feedBaseUrl
            if let param = after {
                path += "?after="+param
            }
            guard let url = URL(string: path) else {
                preconditionFailure("Invalid URL used to create URL instance")
            }
            
            return URLRequest(url: url)
        }
    }
    
    var mockPath: String {
        switch self {
        case .feed:
            return "feeds"
        }
    }
}

