//
//  ViewController.swift
//  RedditDemo
//
//  Created by Sai Pavan Neerukonda on 3/31/21.
//

import UIKit

class ViewController: UIViewController {
    let viewModel = FeedViewModel()
    let tableView = UITableView()
    lazy var retryButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(#imageLiteral(resourceName: "retry"), for: .normal)
        button.addTarget(self, action: #selector(onTapRetry(_:)), for: .touchUpInside)
        button.pinCenterToView(view)
        button.isHidden = true
        return button
    }()
    
    override func loadView() {
        super.loadView()
        tableView.pinEdgesToView(view, edges: view.safeAreaInsets)
        tableView.register(FeedTableViewCell.self, forCellReuseIdentifier: FeedTableViewCell.reuseIdentifier)
        tableView.register(LoadingTableViewCell.self, forCellReuseIdentifier: LoadingTableViewCell.reuseIdentifier)
        tableView.separatorStyle = .none
        tableView.dataSource = self
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.backgroundColor = .systemGray5
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchFeeds()
    }

    func fetchFeeds() {
        tableView.isHidden = false
        viewModel.fetchFeeds { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(_):
                    self?.tableView.isHidden = false
                    self?.tableView.reloadData()
                case .failure(_):
                    let show = !(self?.viewModel.cellModels.isEmpty ?? false)
                    self?.tableView.isHidden = !show
                    self?.retryButton.isHidden = show
                }
            }
        }
    }
    
    @objc func onTapRetry(_ sender: UIButton) {
        fetchFeeds()
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.cellModels.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == viewModel.cellModels.count {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: LoadingTableViewCell.reuseIdentifier, for: indexPath) as? LoadingTableViewCell else { return UITableViewCell() }
            fetchFeeds()
            return cell
        }
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FeedTableViewCell.reuseIdentifier, for: indexPath) as? FeedTableViewCell else { return UITableViewCell() }
        cell.configure(viewModel: viewModel.cellModels[indexPath.row])
        return cell
    }
}

