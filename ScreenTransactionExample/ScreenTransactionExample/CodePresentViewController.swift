//
//  CodePresentViewController.swift
//  ScreenTransactionExample
//
//  Created by 강태준 on 2022/06/16.
//

import UIKit

protocol SendDataDeligate: AnyObject {
    func sendData(name: String)
}

class CodePresentViewController: UIViewController {
    @IBOutlet weak var nameLabel: UILabel!
    var name: String?
    weak var deligate: SendDataDeligate?
    // weak라는 키워드를 통해 메모리 누수 방지
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let name = name {
            self.nameLabel.text = name
            self.nameLabel.sizeToFit()
        }

        // Do any additional setup after loading the view.
    }
    @IBAction func tapBackButton(_ sender: UIButton) {
        self.deligate?.sendData(name: "KangTaejun")
        self.presentingViewController?.dismiss(animated: true)
    }
}
