//
//  SettingViewController.swift
//  LEDBoard
//
//  Created by 강태준 on 2022/06/16.
//

import UIKit

protocol LEDBoardSettingDeligate: AnyObject {
    func changeSetting(text:String?, textColor: UIColor, backgroundColor: UIColor)
}

class SettingViewController: UIViewController {
    @IBOutlet weak var textFeild: UITextField!
    @IBOutlet weak var purpleButton: UIButton!
    @IBOutlet weak var yellowButton: UIButton!
    @IBOutlet weak var greenButton: UIButton!
    @IBOutlet weak var blackButton: UIButton!
    @IBOutlet weak var blueButton: UIButton!
    @IBOutlet weak var orangeButton: UIButton!
    
    weak var deligate: LEDBoardSettingDeligate?
    var textColor: UIColor = .yellow
    var backgroundColor: UIColor = .black
    var text: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configView()
    }
    
    private func configView() {
        if let text = self.text {
            self.textFeild.text = text
        }
        self.changeTextColorButtonAlpha(color: textColor)
        self.changeBackgroundColorButtonAlpha(color: backgroundColor)
    }
    
    @IBAction func tapTextColorButton(_ sender: UIButton) {
        let color: UIColor = sender == self.yellowButton ? .yellow : sender == self.purpleButton ? .purple : .green
        self.changeTextColorButtonAlpha(color: color)
        self.textColor = color
    }
    
    @IBAction func tapBackgroundColorButton(_ sender: UIButton) {
        let color: UIColor = sender == self.blackButton ? .black : sender == self.blueButton ? .blue : .orange
        self.changeBackgroundColorButtonAlpha(color: color)
        self.backgroundColor = color
    }
    
    @IBAction func tapSaveButton(_ sender: UIButton) {
        self.deligate?.changeSetting(text: self.textFeild.text, textColor: self.textColor, backgroundColor: self.backgroundColor)
        self.navigationController?.popViewController(animated: true)
    }
    
    private func changeTextColorButtonAlpha(color: UIColor) {
        self.yellowButton.alpha = color == UIColor.yellow ? 1 : 0.2
        self.purpleButton.alpha = color == UIColor.purple ? 1 : 0.2
        self.greenButton.alpha = color == UIColor.green ? 1 : 0.2
    }
    
    private func changeBackgroundColorButtonAlpha(color: UIColor) {
        self.blackButton.alpha = color == UIColor.black ? 1 : 0.2
        self.blueButton.alpha = color == UIColor.blue ? 1 : 0.2
        self.orangeButton.alpha = color == UIColor.orange ? 1 : 0.2
    }
}
