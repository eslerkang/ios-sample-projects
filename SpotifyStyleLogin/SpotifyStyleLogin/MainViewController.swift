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
        let displayName = Auth.auth().currentUser?.displayName ?? Auth.auth().currentUser?.email ?? "고객"
        self.welcomeLabel.text = """
        환영합니다.
        \(displayName)님
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
    
    @IBAction func tapProfileUpdateButton(_ sender: UIButton) {
        let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
        changeRequest?.displayName = "토끼"
        changeRequest?.commitChanges(completion: { [weak self] _ in
            let displayName = Auth.auth().currentUser?.displayName ?? Auth.auth().currentUser?.email ?? "고객"
            
            self?.welcomeLabel.text = """
            환영합니다.
            \(displayName)님
            """
        })
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
