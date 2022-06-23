//
//  EnterEmailViewController.swift
//  SpotifyStyleLogin
//
//  Created by 강태준 on 2022/06/23.
//

import UIKit
import FirebaseAuth

class EnterEmailViewController: UIViewController {
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var errorMessageLabel: UILabel!
    @IBOutlet weak var nextButton: UIButton!
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        // show navigationBar
        self.navigationController?.navigationBar.isHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        emailTextField.delegate = self
        passwordTextField.delegate = self
        emailTextField.becomeFirstResponder()
    }
    
    @IBAction func tapNextButton(_ sender: UIButton) {
        // Firabase email/password auth
        let email = emailTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        
        // Create new user
        Auth.auth().createUser(withEmail: email, password: password, completion: { [weak self] authResult, error in
            guard let self = self else {return}
            
            if let error = error {
                let code = (error as NSError).code
                switch code {
                case 17007: // 이미 가입한 계정
                    // 로그인하기
                    self.loginUser(email: email, password: password)
                default:
                    self.errorMessageLabel.text = error.localizedDescription
                }
            } else {
                self.showMainViewController()
            }
        })
    }
    
    private func loginUser(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password, completion: { [weak self] authResult, error in
            guard let self = self else {return}
            
            if let error = error {
                self.errorMessageLabel.text = error.localizedDescription
            } else {
                self.showMainViewController()
            }
        })
    }
    
    private func showMainViewController() {
        guard let mainViewController = self.storyboard?.instantiateViewController(withIdentifier: "MainViewController") as? MainViewController else {return}
        mainViewController.modalPresentationStyle = .fullScreen
        navigationController?.show(mainViewController, sender: nil)
    }
    
    func configureButton() {
        nextButton.layer.cornerRadius = 30
        nextButton.isEnabled = false
    }
    
    func configureTextField() {
        
    }
}

extension EnterEmailViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return false
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        let isEmailEmpty = emailTextField.text == ""
        let isPasswordEmpty = passwordTextField.text == ""
        nextButton.isEnabled = !isEmailEmpty && !isPasswordEmpty
    }
}
