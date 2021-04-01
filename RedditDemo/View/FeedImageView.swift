//
//  FeedImageView.swift
//  RedditDemo
//
//  Created by Sai Pavan Neerukonda on 4/1/21.
//

import UIKit

class FeedImageView: UIView {
    let imageView = UIImageView()
    let retryButton = UIButton(type: .custom)
    let indicator = UIActivityIndicatorView()
    private var retryURL: URL?
    var image: UIImage? {
        set {
            imageView.image = newValue
        }
        get {
            return imageView.image
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        imageView.pinEdgesToView(self)
        retryButton.pinCenterToView(self)
        indicator.pinCenterToView(self)
        indicator.hidesWhenStopped = true
        indicator.startAnimating()
        retryButton.setImage(#imageLiteral(resourceName: "retry"), for: .normal)
        retryButton.isHidden = true
        retryButton.addTarget(self, action: #selector(onTapRetry(_:)), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func loadImage(at url: URL) {
        retryURL = url
        FeedImageLoader.loader.load(url, for: self)
    }

    func cancelImageLoad() {
        retryURL = nil
        retryButton.isHidden = true
        indicator.startAnimating()
        FeedImageLoader.loader.cancel(for: self)
    }
    
    @objc func onTapRetry(_ sender: UIButton) {
        guard let url = retryURL else { return }
        FeedImageLoader.loader.load(url, isRetry: true, for: self)
    }
}
