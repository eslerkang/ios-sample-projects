//
//  BeerDetailViewController.swift
//  Brewery
//
//  Created by 강태준 on 2022/08/02.
//

import UIKit
import SnapKit
import Kingfisher


class BeerDetailViewController: UITableViewController {
    var beer: Beer?
    
    let cellIdentifier = "BeerDetailListCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTableView()
    }
    
    func configureTableView() {
        title = beer?.name ?? "이름 없는 맥주"
        
        tableView = UITableView(frame: tableView.frame, style: .insetGrouped)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier )
        tableView.rowHeight = UITableView.automaticDimension
        
        let frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        let headerView = UIImageView(frame: frame)
        let imageURL = URL(string: beer?.imageURL ?? "")
        
        headerView.contentMode = .scaleAspectFit
        headerView.kf.setImage(with: imageURL, placeholder: UIImage(systemName: "beer_icon"), options: nil, completionHandler: nil)
        
        tableView.tableHeaderView = headerView
    }
}


extension BeerDetailViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 3:
            return beer?.foodPairing?.count ?? 0
        default:
            return 1
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "ID"
        case 1:
            return "Description"
        case 2:
            return "Brewers Tip"
        case 3:
            let isFoodPairingEmpty = beer?.foodPairing?.isEmpty ?? true
            return isFoodPairingEmpty ? nil : "Food Pairing"
        default:
            return nil
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: cellIdentifier)
        
        cell.textLabel?.numberOfLines = 0
        
        cell.selectionStyle = .none
        
        switch indexPath.section {
        case 0:
            cell.textLabel?.text = String(describing: beer?.id ?? 0)
            return cell
        case 1:
            cell.textLabel?.text = beer?.description ?? "설명 없는 맥주"
            return cell
        case 2:
            cell.textLabel?.text = beer?.brewersTips ?? "팁 없는 맥주"
            return cell
        case 3:
            cell.textLabel?.text = beer?.foodPairing?[indexPath.row] ?? ""
            return cell
        default:
            return cell
        }
    }
}
