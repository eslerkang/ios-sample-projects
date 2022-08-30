//
//  UIButton+.swift
//  Instagram
//
//  Created by 강태준 on 2022/08/30.
//

import UIKit


extension UIButton {
    func setImage(systemName: String) {
        contentHorizontalAlignment = .fill
        contentVerticalAlignment = .fill
        
        imageView?.contentMode = .scaleAspectFill
        
        setImage(UIImage(systemName: systemName), for: .normal)
        
    }
}
