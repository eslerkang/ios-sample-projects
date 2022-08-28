//
//  RankingFeatureSectionCollectionViewCell.swift
//  AppStore
//
//  Created by 강태준 on 2022/08/28.
//

import UIKit
import SnapKit


final class RankingFeatureSectionCollectionViewCell: UICollectionViewCell {
    static var height: CGFloat = 70
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 7
        imageView.layer.borderWidth = 0.5
        imageView.layer.borderColor = UIColor.separator.cgColor
        
        return imageView
    }()
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .bold)
        
        return label
    }()
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13, weight: .semibold)
        label.textColor = .secondaryLabel
        
        return label
    }()
    private lazy var installButton: UIButton = {
        let button = UIButton()
        button.setTitle("받기", for: .normal)
        button.setTitleColor(UIColor.systemBlue, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 13, weight: .bold)
        button.layer.cornerRadius = 12
        button.backgroundColor = .secondarySystemBackground
        
        return button
    }()
    private lazy var inAppPurchaseLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 10, weight: .semibold)
        label.text = "앱 내 구입"
        label.textColor = .secondaryLabel
        
        return label
    }()
    
    func setup(rankingFeature: RankingFeature) {
        setupLayout()
        
        titleLabel.text = rankingFeature.title
        descriptionLabel.text = rankingFeature.description
        inAppPurchaseLabel.isHidden = rankingFeature.isInPurchaseApp
        imageView.backgroundColor = .tertiarySystemGroupedBackground
    }
}


private extension RankingFeatureSectionCollectionViewCell {
    func setupLayout() {
        [
            imageView,
            titleLabel,
            descriptionLabel,
            installButton,
            inAppPurchaseLabel
        ].forEach {
            addSubview($0)
        }
        
        imageView.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(16)
            $0.top.bottom.equalToSuperview().inset(4)
            $0.width.equalTo(imageView.snp.height)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(8)
            $0.leading.equalTo(imageView.snp.trailing).offset(8)
            $0.trailing.equalTo(installButton.snp.leading).offset(-8)
        }
        
        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(4)
            $0.leading.trailing.equalTo(titleLabel)
        }
        
        installButton.snp.makeConstraints {
            $0.width.equalTo(50)
            $0.trailing.equalToSuperview().inset(16)
            $0.centerY.equalToSuperview()
            $0.height.equalTo(24)
        }
        
        inAppPurchaseLabel.snp.makeConstraints {
            $0.centerX.equalTo(installButton)
            $0.top.equalTo(installButton.snp.bottom).offset(4)
        }
    }
}
