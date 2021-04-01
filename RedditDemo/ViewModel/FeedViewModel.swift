//
//  FeedViewModel.swift
//  RedditDemo
//
//  Created by Sai Pavan Neerukonda on 3/31/21.
//

import Foundation

class FeedViewModel {
    private var feeds: [Child] = []
    var cellModels: [FeedCellViewModel] = []
    var isFetchInProgress = false
    var after: String?
    
    let service: FeedProviding
    
    init(service: FeedProviding = FeedProvider()) {
        self.service = service
      }
    
    func fetchFeeds(completion: @escaping (Result<Void, Error>) -> Void) {
        guard !isFetchInProgress else { return }
        isFetchInProgress = true
        service.getFeed(after: after) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let welcome):
                self.feeds += welcome.data.children
                self.after = welcome.data.after
                self.prepareCellModels(newFeeds: welcome.data.children)
                completion(.success(()))
                self.isFetchInProgress = false
            case .failure(let error):
                self.isFetchInProgress = false
                completion(.failure(error))
            }
        }
    }
    
    func prepareCellModels(newFeeds: [Child]) {
        cellModels += newFeeds.map({ child in
            return FeedCellViewModel(child: child)
        })
    }
}
