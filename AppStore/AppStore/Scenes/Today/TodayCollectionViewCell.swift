//
//  TodayCollectionViewCell.swift
//  AppStore
//
//  Created by 강태준 on 2022/08/26.
//

import UIKit
import SnapKit


final class TodayCollectionViewCell: UICollectionViewCell {
    private lazy var subTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 14, weight: .bold)
        
        return label
    }()
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 24, weight: .bold)
        
        return label
    }()
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 14, weight: .bold)
        
        return label
    }()
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 12
        imageView.backgroundColor = .gray
        
        return imageView
    }()
    
    func setup() {
        setupSubViews()
        
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.5
        layer.shadowRadius = 10
        
        subTitleLabel.text = "하루에 2L 도전해보세요"
        titleLabel.text = "물 마시기 운동"
        descriptionLabel.text = "가장 간단하게 건강을 챙기는 방법!"
    }
}


private extension TodayCollectionViewCell {
    func setupSubViews() {
        [imageView, titleLabel, subTitleLabel, descriptionLabel].forEach {
            addSubview($0)
        }
        
        subTitleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(24)
            $0.trailing.equalToSuperview().inset(24)
            $0.top.equalToSuperview().inset(24)
        }
        
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(subTitleLabel.snp.bottom).offset(4)
            $0.leading.equalTo(subTitleLabel)
            $0.trailing.equalTo(subTitleLabel)
        }
        
        
        descriptionLabel.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(24)
            $0.leading.equalToSuperview().inset(24)
            $0.trailing.equalToSuperview().inset(24)
        }
        
        imageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
