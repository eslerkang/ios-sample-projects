//
//  RankingFeatureSectionCollectionViewHeader.swift
//  AppStore
//
//  Created by 강태준 on 2022/08/29.
//

import UIKit
import SnapKit


final class RankingFeatureSectionCollectionViewHeader: UICollectionReusableView {
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .black)
        
        return label
    }()
    private lazy var showAllButton: UIButton = {
        let button = UIButton()
        button.setTitle("모두 보기", for: .normal)
        button.setTitleColor(UIColor.systemBlue, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 14, weight: .semibold)
        
        return button
    }()
    
    func setup() {
        titleLabel.text = "iPhone이 처음이라면"
        
        [
            titleLabel,
            showAllButton
        ].forEach {
            addSubview($0)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.leading.bottom.equalToSuperview().inset(16)
            $0.trailing.equalTo(showAllButton.snp.leading)
        }
        
        showAllButton.snp.makeConstraints {
            $0.top.bottom.trailing.equalToSuperview().inset(16)
        }
    }
}
