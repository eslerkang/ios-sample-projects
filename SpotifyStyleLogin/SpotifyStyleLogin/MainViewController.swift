//
//  MainViewController.swift
//  SpotifyStyleLogin
//
//  Created by 강태준 on 2022/06/23.
//

import UIKit

class MainViewController: UIViewController {
    @IBOutlet weak var welcomeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.isHidden = true
    }
    
    @IBAction func tapLogoutButton(_ sender: UIButton) {
        self.navigationController?.popToRootViewController(animated: true)
    }
}
