//
//  FeedTableViewCell.swift
//  RedditDemo
//
//  Created by Sai Pavan Neerukonda on 3/31/21.
//

import UIKit

class FeedTableViewCell: UITableViewCell {
    static let reuseIdentifier = "FeedCell"
    
    let title = UILabel()
    let commentNumber = UIButton(type: .system)
    let share = UIButton(type: .system)
    let score = UIButton(type: .system)
    let thumbnail = FeedImageView()
    var viewModel: FeedCellViewModel!
    var thumbnailWidthAnchor: NSLayoutConstraint?
    var thumbnailHeightAnchor: NSLayoutConstraint?
    let separator = UIView()
    
    lazy var width: NSLayoutConstraint = {
        let width = contentView.widthAnchor.constraint(equalToConstant: bounds.size.width)
        width.isActive = true
        return width
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        removeImageConstraints()
        thumbnail.image = #imageLiteral(resourceName: "placeholder")
        thumbnail.cancelImageLoad()
    }
    
    private func configureUI() {
        contentView.layer.cornerRadius = 10
        contentView.backgroundColor = .white
        title.pinEdgesToView(contentView, edges: UIEdgeInsets(top: 10, left: 20, bottom: 0, right: 20), except: [.bottom])
        title.numberOfLines = 0
        title.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        let stack = UIStackView(arrangedSubviews: [score, commentNumber, share])
        stack.distribution = .equalSpacing
        stack.pinEdgesToView(contentView, edges: UIEdgeInsets(top: 0, left: 20, bottom: 20, right: 20), except: [.top])
        thumbnail.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(thumbnail)
        thumbnail.add(constarint: .centerX, view: contentView)
        thumbnail.add(constarint: .vertical, view: title, constant: 15)
        stack.add(constarint: .vertical, view: thumbnail, constant: 10)
        title.setContentHuggingPriority(.required, for: .vertical)
        share.setImage(#imageLiteral(resourceName: "share"), for: .normal)
        share.setTitle("Share", for: .normal)
        commentNumber.setImage(#imageLiteral(resourceName: "comments"), for: .normal)
        score.setImage(#imageLiteral(resourceName: "ups"), for: .normal)
        separator.pinEdgesToView(contentView, except: [.top])
        separator.backgroundColor = .systemGray5
        separator.heightAnchor.constraint(equalToConstant: 8).isActive = true
        thumbnail.image = #imageLiteral(resourceName: "placeholder")
    }
    
    func configure(viewModel: FeedCellViewModel) {
        self.viewModel = viewModel
        title.text = viewModel.title
        score.setTitle(viewModel.score, for: .normal)
        commentNumber.setTitle(viewModel.comments, for: .normal)
        if let url = URL(string: viewModel.imageURL) {
            thumbnail.loadImage(at: url)
        }
        guard let width = viewModel.imageWidth, let height = viewModel.imageHeight else {
            return removeImageConstraints()
        }
        thumbnailHeightAnchor = thumbnail.heightAnchor.constraint(equalToConstant: CGFloat(height))
        thumbnailWidthAnchor = thumbnail.widthAnchor.constraint(equalToConstant: CGFloat(width))
        enableImageViewConstraints(true)
    }
    
    func enableImageViewConstraints(_ enable: Bool) {
        thumbnailHeightAnchor?.isActive = enable
        thumbnailWidthAnchor?.isActive = enable
        layoutIfNeeded()
    }
    
    func removeImageConstraints() {
        guard let thumbnailWidthAnchor = thumbnailWidthAnchor,
              let thumbnailHeightAnchor = thumbnailHeightAnchor else { return }
        thumbnail.removeConstraint(thumbnailWidthAnchor)
        thumbnail.removeConstraint(thumbnailHeightAnchor)
        layoutIfNeeded()
    }
}
