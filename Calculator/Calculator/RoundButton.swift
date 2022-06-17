//
//  RoundButton.swift
//  Calculator
//
//  Created by 강태준 on 2022/06/16.
//

import UIKit

@IBDesignable
class RoundButton: UIButton {
    @IBInspectable var isRound:Bool = false {
        didSet {
            if isRound {
                self.layer.cornerRadius = self.frame.height / 2
            }
        }
    }
}
