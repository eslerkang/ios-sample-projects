//
//  TodayCollectionViewHeader.swift
//  AppStore
//
//  Created by 강태준 on 2022/08/26.
//

import UIKit
import SnapKit


final class TodayCollectionViewHeader: UICollectionReusableView {
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .semibold)
        label.textColor = .secondaryLabel
        
        return label
    }()
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 36, weight: .black)
        label.textColor = .label
        
        return label
    }()
    
    func setup() {
        dateLabel.text = "22년 09월 01일"
        titleLabel.text = "랄라라라라ㅏ"
        
        [dateLabel, titleLabel].forEach {
            addSubview($0)
        }
        
        dateLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(16)
            $0.trailing.equalToSuperview()
            $0.top.equalToSuperview().inset(32)
        }
        
        titleLabel.snp.makeConstraints {
            $0.leading.equalTo(dateLabel)
            $0.top.equalTo(dateLabel.snp.bottom).offset(8)
        }
    }
}


