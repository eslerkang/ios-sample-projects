//
//  AddAlertViewController.swift
//  Drink
//
//  Created by 강태준 on 2022/07/26.
//

import UIKit

class AddAlertViewController: UIViewController {
    @IBOutlet weak var datePicker: UIDatePicker!
    
    var pickedDate: ((_ date: Date) -> Void)?
    
    @IBAction func tapCancelButton(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true)
    }
    
    @IBAction func tapSaveButton(_ sender: UIBarButtonItem) {
        pickedDate?(datePicker.date)
        self.dismiss(animated: true)
    }
}
