//
//  AppDetailViewController.swift
//  AppStore
//
//  Created by 강태준 on 2022/08/28.
//

import UIKit
import SnapKit


final class AppDetailViewController: UIViewController {
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .bold)
        
        return label
    }()
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.textColor = .secondaryLabel
        
        return label
    }()
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 8
        
        return imageView
    }()
    private lazy var installButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemBlue
        button.setTitle("받기", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 13, weight: .bold)
        button.layer.cornerRadius = 12.0
        
        return button
    }()
    private lazy var shareButton: UIButton = {
        let button = UIButton()
        button.tintColor = .systemBlue
        button.setImage(UIImage(systemName: "square.and.arrow.up"), for: .normal)
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        setupLayout()
        
        titleLabel.text = "title"
        descriptionLabel.text = "description"
        imageView.backgroundColor = .lightGray
    }
}


private extension AppDetailViewController {
    func setupLayout() {
        [
            imageView,
            titleLabel,
            descriptionLabel,
            installButton,
            shareButton
        ].forEach {
            view.addSubview($0)
        }
        
        imageView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(32)
            $0.leading.equalToSuperview().inset(16)
            $0.width.equalTo(100)
            $0.height.equalTo(imageView.snp.width)
        }
        
        titleLabel.snp.makeConstraints {
            $0.leading.equalTo(imageView.snp.trailing).offset(16)
            $0.top.equalTo(imageView)
            $0.trailing.equalToSuperview().inset(16)
        }
        
        descriptionLabel.snp.makeConstraints {
            $0.leading.trailing.equalTo(titleLabel)
            $0.top.equalTo(titleLabel.snp.bottom).offset(4)
        }
        
        installButton.snp.makeConstraints {
            $0.width.equalTo(60)
            $0.height.equalTo(24)
            $0.leading.equalTo(titleLabel)
            $0.bottom.equalTo(imageView)
        }
        
        shareButton.snp.makeConstraints {
            $0.width.height.equalTo(32)
            $0.centerY.equalTo(installButton)
            $0.trailing.equalTo(titleLabel)
        }
    }
}
