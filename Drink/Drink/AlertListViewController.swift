//
//  AlertListViewController.swift
//  Drink
//
//  Created by 강태준 on 2022/07/26.
//

import UIKit

class AlertListViewController: UITableViewController {
    
    var alertList = [Alert]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerTableViewCell()
        
        alertList = loadAlertList()
    }
    
    private func registerTableViewCell() {
        let nibName = UINib(nibName: "AlertListTableViewCell", bundle: nil)
        tableView.register(nibName, forCellReuseIdentifier: "AlertListTableViewCell")
    }
    
    @IBAction func tapPlusButon(_ sender: UIBarButtonItem) {
        guard let addAlertViewController = storyboard?.instantiateViewController(withIdentifier: "AddAlertViewController") as? AddAlertViewController else {return}
        
        addAlertViewController.pickedDate = { [weak self] date in
            guard let self = self else {return}
            
            var alertList = self.loadAlertList()
            let newAlert = Alert(date: date, isOn: true)
            
            alertList.append(newAlert)
            alertList.sort {
                $0.date < $1.date
            }
            
            self.alertList = alertList
            
            self.setAlertList()
            
            self.tableView.reloadData()
        }
        
        self.present(addAlertViewController, animated: true)
    }
    
    func loadAlertList() -> [Alert] {
        guard let data = UserDefaults.standard.value(forKey: "alerts") as? Data,
              let alerList = try? PropertyListDecoder().decode([Alert].self, from: data)
        else {
            return []
        }
        
        return alerList
    }
    
    func setAlertList() {
        UserDefaults.standard.set(try? PropertyListEncoder().encode(self.alertList), forKey: "alerts")
    }
}


extension AlertListViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return alertList.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "🚰물마실 시간"
        default:
            return nil
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "AlertListTableViewCell", for: indexPath) as? AlertListTableViewCell else { return UITableViewCell() }
        
        cell.alertSwitch.isOn = alertList[indexPath.row].isOn
        cell.timeLabel.text = alertList[indexPath.row].time
        cell.meridiemLabel.text = alertList[indexPath.row].merdiem
        
        cell.alertSwitch.tag = indexPath.row
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle {
        case .delete:
            // notification delete
            self.alertList.remove(at: indexPath.row)
            setAlertList()
            self.tableView.reloadData()
            return
        default:
            break
        }
    }
}
