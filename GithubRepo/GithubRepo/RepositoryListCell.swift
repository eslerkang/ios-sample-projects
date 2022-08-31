//
//  RepositoryListCell.swift
//  GithubRepo
//
//  Created by 강태준 on 2022/08/31.
//

import UIKit
import SnapKit


final class RepositoryListCell: UITableViewCell {
    var repository: Repository?
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .bold)
        
        return label
    }()
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15)
        label.numberOfLines = 2
        
        return label
    }()
    private lazy var starImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "star")
        
        return imageView
    }()
    private lazy var starLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        label.textColor = .secondaryLabel
        
        return label
    }()
    private lazy var langLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        label.textColor = .secondaryLabel
        
        return label
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        guard let repository = repository else {
            return
        }
        
        nameLabel.text = repository.name
        descriptionLabel.text = repository.description
        starLabel.text = "\(repository.star)"
        langLabel.text = repository.language
        
        [
            nameLabel,
            descriptionLabel,
            starImageView,
            starLabel,
            langLabel
        ].forEach {
            addSubview($0)
        }
        
        nameLabel.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview().inset(18)
        }
        
        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(nameLabel.snp.bottom).offset(3)
            $0.leading.trailing.equalTo(nameLabel)
        }
        
        starImageView.snp.makeConstraints {
            $0.top.equalTo(descriptionLabel.snp.bottom).offset(12)
            $0.leading.equalTo(descriptionLabel)
            $0.bottom.equalToSuperview().inset(18)
            $0.width.equalTo(starImageView.snp.height)
        }
        
        starLabel.snp.makeConstraints {
            $0.centerY.equalTo(starImageView)
            $0.leading.equalTo(starImageView.snp.trailing).offset(6)
        }
        
        langLabel.snp.makeConstraints {
            $0.centerY.equalTo(starLabel)
            $0.leading.equalTo(starLabel.snp.trailing).offset(6)
        }
    }
}
