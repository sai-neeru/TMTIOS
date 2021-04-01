//
//  ImageLoader.swift
//  RedditDemo
//
//  Created by Sai Pavan Neerukonda on 3/31/21.
//

import UIKit

class ImageLoader {
    private var loadedImages = [URL: UIImage]()
    private var runningRequests = [UUID: URLSessionDataTask]()
    private var errorURL = [URL: Error]()
    
    func loadImage(_ url: URL, isRetry: Bool = false,  _ completion: @escaping (Result<UIImage, Error>) -> Void) -> UUID? {
        
        // 1
        if let image = loadedImages[url] {
            completion(.success(image))
            return nil
        }
        
        if let error = errorURL[url], !isRetry {
            completion(.failure(error))
            return nil
        }
        errorURL.removeValue(forKey: url)
        
        // 2
        let uuid = UUID()
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            // 3
            defer {self.runningRequests.removeValue(forKey: uuid) }
            
            // 4
            if let data = data, let image = UIImage(data: data) {
                self.loadedImages[url] = image
                completion(.success(image))
                return
            }
            
            // 5
            guard let error = error else {
                let unknown = NSError(domain: "No data", code: 0, userInfo: nil)
                self.errorURL[url] = unknown
                completion(.failure(unknown))
                return
            }
            
            guard (error as NSError).code == NSURLErrorCancelled else {
                self.errorURL[url] = error
                completion(.failure(error))
                return
            }
            
            // the request was cancelled, no need to call the callback
        }
        task.resume()
        
        // 6
        runningRequests[uuid] = task
        return uuid
    }
    
    func cancelLoad(_ uuid: UUID) {
      runningRequests[uuid]?.cancel()
      runningRequests.removeValue(forKey: uuid)
    }
}

class FeedImageLoader {
  static let loader = FeedImageLoader()

  private let imageLoader = ImageLoader()
  private var uuidMap = [FeedImageView: UUID]()

  private init() {}

    func load(_ url: URL, isRetry: Bool = false, for feedView: FeedImageView) {
        feedView.indicator.startAnimating()
        let token = imageLoader.loadImage(url, isRetry: isRetry) { result in
            defer { self.uuidMap.removeValue(forKey: feedView) }
            do {
                let image = try result.get()
                DispatchQueue.main.async {
                    feedView.retryButton.isHidden = true
                    feedView.indicator.stopAnimating()
                    feedView.image = image
                }
            } catch {
                DispatchQueue.main.async {
                    feedView.retryButton.isHidden = false
                    feedView.indicator.stopAnimating()
                }
            }
        }
        
        if let token = token {
            uuidMap[feedView] = token
        }
    }

    func cancel(for feedView: FeedImageView) {
      if let uuid = uuidMap[feedView] {
        imageLoader.cancelLoad(uuid)
        uuidMap.removeValue(forKey: feedView)
      }
    }
}
