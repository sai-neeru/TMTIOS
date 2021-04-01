//
//  FeedProvider.swift
//  RedditDemo
//
//  Created by Sai Pavan Neerukonda on 4/1/21.
//

import Foundation

protocol FeedProviding {
  var network: Networking { get set }

  func getFeed(after: String?, completion: @escaping (Result<Welcome, Error>) -> Void)
}

extension FeedProviding {
    func getFeed(after: String? = nil, completion: @escaping (Result<Welcome, Error>) -> Void) {
        network.execute(Endpoint.feed(after), completion: completion)
    }
}

class FeedProvider: FeedProviding {
    var network: Networking
    
    init(network: Networking = BaseNetworking()) {
        self.network = network
    }
}
