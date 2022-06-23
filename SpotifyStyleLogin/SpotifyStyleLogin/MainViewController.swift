//
//  MainViewController.swift
//  SpotifyStyleLogin
//
//  Created by 강태준 on 2022/06/23.
//

import UIKit
import FirebaseAuth

class MainViewController: UIViewController {
    @IBOutlet weak var welcomeLabel: UILabel!
    @IBOutlet weak var changePasswordButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.isHidden = true
        
        self.configureWelcomeLabel()
        
        let isEmailSignin = Auth.auth().currentUser?.providerData[0].providerID == "password"
        changePasswordButton.isHidden = !isEmailSignin
    }
    
    func configureWelcomeLabel() {
        let email = Auth.auth().currentUser?.email ?? "고객"
        self.welcomeLabel.text = """
        환영합니다.
        \(email)님
        """
    }
    
    @IBAction func tapLogoutButton(_ sender: UIButton) {
        self.logout()
    }
    
    @IBAction func tapChangePasswordButton(_ sender: UIButton) {
        let email = Auth.auth().currentUser?.email ?? ""
        Auth.auth().sendPasswordReset(withEmail: email, completion: nil)
        self.logout()
    }
    
    private func logout() {
        do {
            try Auth.auth().signOut()
            self.navigationController?.popToRootViewController(animated: true)
        } catch let signoutError as NSError {
            print("ERROR: \(signoutError.localizedDescription)")
        }
    }
}
