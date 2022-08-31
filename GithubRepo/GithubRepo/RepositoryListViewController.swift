//
//  ViewController.swift
//  GithubRepo
//
//  Created by 강태준 on 2022/08/31.
//

import UIKit
import RxSwift
import RxCocoa


final class RepositoryListViewController: UITableViewController {
    private let organization = "Apple"
    private let repositoryList = BehaviorSubject<[Repository]>(value: [])
    private let disposeBag = DisposeBag()
    
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
        
        fetchData(of: organization)
    }
}


extension RepositoryListViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        do {
            return try repositoryList.value().count
        } catch {
            print("ERROR: \(error.localizedDescription)")
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "RepositoryTableCell") as? RepositoryListCell
        else {
            return UITableViewCell()
        }
        
        do {
            cell.repository = try repositoryList.value()[indexPath.row]
        } catch {
            print("ERROR: \(error.localizedDescription)")
        }
        
        return cell
    }
}


private extension RepositoryListViewController {
    func fetchData(of organization: String) {
        Observable.from([organization])
            .map { organization -> URL in
                URL(string: "https://api.github.com/orgs/\(organization)/repos")!
            }
            .map { url -> URLRequest in
                var urlRequest = URLRequest(url: url)
                urlRequest.httpMethod = "GET"
                return urlRequest
            }
            .flatMap { request -> Observable<(response: HTTPURLResponse, data: Data)> in
                return URLSession.shared.rx.response(request: request)
            }
            .filter { response, _ in
                return 200..<300 ~= response.statusCode
            }
            .map { _, data -> [Repository] in
                guard let repositories = try? JSONDecoder().decode([Repository].self, from: data)
                else {
                    return []
                }
                
                return repositories
            }
            .filter { repositories in
                repositories.count > 0
            }
            .subscribe(onNext: { repositories in
                self.repositoryList.onNext(repositories)
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    self.refresher.endRefreshing()
                }
            })
            .disposed(by: disposeBag)
    }
    
    func setupNavigation() {
        navigationItem.title = organization + " Repository"
    }
    
    func setupTableView() {
        tableView.refreshControl = refresher
        
        tableView.register(RepositoryListCell.self, forCellReuseIdentifier: "RepositoryTableCell")
        tableView.rowHeight = 140
        
        tableView.allowsSelection = false
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    @objc func refresh() {
        self.fetchData(of: self.organization)
    }
}
