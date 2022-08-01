//
//  ContentCollectionViewRankCell.swift
//  NetflixStyleSampleApp
//
//  Created by 강태준 on 2022/08/01.
//

import UIKit
import SnapKit

 
class ContentCollectionViewRankCell: UICollectionViewCell {
    let imageView = UIImageView()
    let rankLabel = UILabel()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // contentView
        contentView.layer.cornerRadius = 5
        contentView.clipsToBounds = true
        
        imageView.contentMode = .scaleToFill
        contentView.addSubview(imageView)
        
        imageView.snp.makeConstraints {
            $0.top.trailing.bottom.equalToSuperview()
            $0.width.equalToSuperview().multipliedBy(0.8)
        }
        
        rankLabel.font = .systemFont(ofSize: 100, weight: .black)
        rankLabel.textColor = .white
        contentView.addSubview(rankLabel)
        
        rankLabel.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.bottom.equalToSuperview().offset(20)
        }
    }
}
