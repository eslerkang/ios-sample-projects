//
//  RepositoryListCell.swift
//  GithubRepo
//
//  Created by 강태준 on 2022/08/31.
//

import UIKit
import SnapKit


final class RepositoryListCell: UITableViewCell {
    var repository: String?
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        
        return label
    }()
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        
        return label
    }()
    private lazy var starImageView: UIImageView = {
        let imageView = UIImageView()
        
        return imageView
    }()
    private lazy var starLabel: UILabel = {
        let label = UILabel()
        
        return label
    }()
    private lazy var langLabel: UILabel = {
        let label = UILabel()
        
        return label
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        [
            nameLabel,
            descriptionLabel,
            starImageView,
            starLabel,
            langLabel
        ].forEach {
            addSubview($0)
        }
    }
}
