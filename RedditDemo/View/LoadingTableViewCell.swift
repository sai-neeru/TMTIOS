//
//  LoadingTableViewCell.swift
//  RedditDemo
//
//  Created by Sai Pavan Neerukonda on 3/31/21.
//

import UIKit

class LoadingTableViewCell: UITableViewCell {
    static let reuseIdentifier = "LoadingCell"
    
    let indicator = UIActivityIndicatorView(style: .medium)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        indicator.startAnimating()
    }
    
    private func configureUI() {
        contentView.backgroundColor = .systemGray5
        indicator.tintColor = .black
        indicator.startAnimating()
        indicator.pinEdgesToView(contentView, edges: UIEdgeInsets(top: 0, left: 0, bottom: 10, right: 0), except: [.left,.right])
        indicator.add(constarint: .centerX, view: contentView)
    }
    
}
