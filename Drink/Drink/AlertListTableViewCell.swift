//
//  AlertListTableViewCell.swift
//  Drink
//
//  Created by 강태준 on 2022/07/26.
//

import UIKit
import UserNotifications

class AlertListTableViewCell: UITableViewCell {
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var meridiemLabel: UILabel!
    @IBOutlet weak var alertSwitch: UISwitch!
    
    let notificationCenter = UNUserNotificationCenter.current()
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func tapAlertSwitch(_ sender: UISwitch) {
        guard let data = UserDefaults.standard.value(forKey: "alerts") as? Data,
              var alertList = try? PropertyListDecoder().decode([Alert].self, from: data)
        else {return}
        
        alertList[sender.tag].isOn = sender.isOn
        UserDefaults.standard.set(try? PropertyListEncoder().encode(alertList), forKey: "alerts")
        
        if sender.isOn {
            notificationCenter.addNotificationRequest(by: alertList[sender.tag])
        } else {
            notificationCenter.removePendingNotificationRequests(withIdentifiers: [alertList[sender.tag].id])
        }
    }
}
