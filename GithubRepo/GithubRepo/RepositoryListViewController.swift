//
//  ViewController.swift
//  GithubRepo
//
//  Created by 강태준 on 2022/08/31.
//

import UIKit

final class RepositoryListViewController: UITableViewController {
    private let organization = "Apple"
    private lazy var refresher: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.backgroundColor = .systemBackground
        refreshControl.tintColor = .secondaryLabel
        refreshControl.attributedTitle = NSAttributedString(string: "당겨서 새로고침")
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        
        return refreshControl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigation()
        setupTableView()
    }
}


extension RepositoryListViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 10
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "RepositoryTableCell") as? RepositoryListCell
        else {
            return UITableViewCell()
        }
        
        return cell
    }
}


private extension RepositoryListViewController {
    func setupNavigation() {
        navigationItem.title = organization + " Repository"
    }
    
    func setupTableView() {
        tableView.refreshControl = refresher
        
        tableView.register(RepositoryListCell.self, forCellReuseIdentifier: "RepositoryTableCell")
        tableView.rowHeight = 140
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    @objc func refresh() {
        refresher.endRefreshing()
    }
}
