//
//  BeerListViewController.swift
//  Brewery
//
//  Created by 강태준 on 2022/08/02.
//

import UIKit
import SnapKit


class BeerListViewController: UITableViewController {
    var beerList = [Beer]()
    var currentPage = 1
    var dataTasks = [URLSessionTask]()
    
    let cellIdentifier = "BeerListCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigaztionBar()
        configureTableView()
        
        fetchBeer(of: currentPage)
    }
    
    func configureTableView() {
        tableView.register(BeerListCell.self, forCellReuseIdentifier: cellIdentifier)
        tableView.rowHeight = 150
        
        tableView.prefetchDataSource = self
    }
    
    func configureNavigaztionBar() {
        title = "브루어리"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
}


extension BeerListViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return beerList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! BeerListCell
        let beer = beerList[indexPath.row]
        cell.configure(with: beer)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedBeer = beerList[indexPath.row]
        let detailViewController = BeerDetailViewController()
        
        detailViewController.beer = selectedBeer
        self.show(detailViewController, sender: nil)
    }
}


private extension BeerListViewController {
    func fetchBeer(of page: Int) {
        guard let url = URL(string: "https://api.punkapi.com/v2/beers?page=\(page)"),
              dataTasks.firstIndex(where: { $0.originalRequest?.url == url }) == nil
        else {return}
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let dataTask = URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            guard error == nil,
                  let self = self,
                  let response = response as? HTTPURLResponse,
                  let data = data,
                  let beers = try? JSONDecoder().decode([Beer].self, from: data) else {
                print("ERROR: URLSession DataTask \(String(describing: error?.localizedDescription))")
                return
            }
            
            switch response.statusCode {
            case (200...299):
                self.beerList += beers
                self.currentPage += 1
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            case (400...499):
                print("""
                ERROR: Client ERROR \(response.statusCode)
                Response: \(response)
                """)
            case (500...599):
                print("""
                ERROR: Server ERROR \(response.statusCode)
                RESPONSE: \(response)
                """)
            default:
                print("""
                ERROR: \(response.statusCode)
                RESPONSE: \(response)
                """)
            }
        }
        
        dataTask.resume()
        dataTasks.append(dataTask)
    }
}


extension BeerListViewController: UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        guard currentPage != 1 else {return}
        
        indexPaths.forEach {
            if($0.row + 1) / 25 + 1 == currentPage {
                self.fetchBeer(of: currentPage)
            }
        }
    }
}
