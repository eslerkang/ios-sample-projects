//
//  ExchangeCodeFooter.swift
//  AppStore
//
//  Created by 강태준 on 2022/08/29.
//

import UIKit
import SnapKit


final class ExchangeCodeFooter: UICollectionReusableView {
    private lazy var exchangeCodeButton: UIButton = {
        let button = UIButton()
        button.setTitle("코드 교환", for: .normal)
        button.setTitleColor(UIColor.systemBlue, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 15, weight: .semibold)
        button.backgroundColor = .tertiarySystemGroupedBackground
        button.layer.cornerRadius = 7
        
        return button
    }()
    
    func setup() {
        addSubview(exchangeCodeButton)
        
        exchangeCodeButton.snp.makeConstraints {
            $0.top.equalToSuperview().inset(32)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(40)
        }
    }
}


