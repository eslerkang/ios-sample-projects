//
//  ProfileCollectionViewCell.swift
//  Instagram
//
//  Created by 강태준 on 2022/08/30.
//

import UIKit
import SnapKit


final class ProfileCollectionViewCell: UICollectionViewCell {
    private let imageView = UIImageView()
    
    func setup(with: UIImage) {
        addSubview(imageView)
        
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .tertiaryLabel
        
        imageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
