//
//  ProfileViewController.swift
//  Instagram
//
//  Created by 강태준 on 2022/08/30.
//

import UIKit
import SnapKit


final class ProfileViewController: UIViewController {
    private lazy var profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.layer.borderWidth = 1
        imageView.layer.borderColor = UIColor.quaternaryLabel.cgColor
        imageView.backgroundColor = .gray
        imageView.layer.cornerRadius = 40
        imageView.contentMode = .scaleAspectFill
        
        imageView.snp.makeConstraints {
            $0.width.height.equalTo(80)
        }
        
        return imageView
    }()
    
    private let postDataView = ProfileDataView(title: "게시물", data: 123)
    private let followerDataView = ProfileDataView(title: "팔로워", data: 2093)
    private let followingDateView = ProfileDataView(title: "팔로잉", data: 92)
    private lazy var dataStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fillEqually
        stackView.spacing = 24
        
        [
            postDataView,
            followerDataView,
            followingDateView
        ].forEach {
            stackView.addArrangedSubview($0)
        }
        
        return stackView
    }()
    
    private lazy var profileStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .center
        stackView.spacing = 24
        
        [
            profileImageView,
            dataStackView
        ].forEach {
            stackView.addArrangedSubview($0)
        }
        
        return stackView
    }()
    
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.text = "UserName"
        label.textColor = .label
        label.font = .systemFont(ofSize: 14, weight: .semibold)
        
        return label
    }()
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "안녕하세요"
        label.numberOfLines = 0
        label.textColor = .secondaryLabel
        label.font = .systemFont(ofSize: 14, weight: .medium)
        
        return label
    }()
    
    private lazy var followButton: UIButton = {
        let button = UIButton()
        button.setTitle("팔로우", for: .normal)
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 3
        button.titleLabel?.font = .systemFont(ofSize: 14, weight: .semibold)
        
        return button
    }()
    private lazy var messageButton: UIButton = {
        let button = UIButton()
        button.setTitle("메시지", for: .normal)
        button.layer.cornerRadius = 3
        button.titleLabel?.font = .systemFont(ofSize: 14, weight: .semibold)
        button.setTitleColor(UIColor.black, for: .normal)
        button.backgroundColor = .white
        button.layer.borderWidth = 0.5
        button.layer.borderColor = UIColor.tertiaryLabel.cgColor
        
        return button
    }()
    private lazy var buttonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .center
        stackView.spacing = 4
        
        [
            followButton,
            messageButton
        ].forEach {
            stackView.addArrangedSubview($0)
        }
        
        return stackView
    }()
    
    private lazy var allProfileStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.alignment = .fill
        stackView.spacing = 12
        
        [
            profileStackView,
            nameLabel,
            descriptionLabel,
            buttonStackView
        ].forEach {
            stackView.addArrangedSubview($0)
        }
        
        return stackView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigation()
        setupLayout()
    }
}


private extension ProfileViewController {
    func setupNavigation() {
        navigationItem.title = "Username"
        
        let settingButton = UIBarButtonItem(
            image: UIImage(systemName: "ellipsis"),
            style: .plain,
            target: self,
            action: nil
        )
        
        navigationItem.rightBarButtonItem = settingButton
    }
    
    func setupLayout() {
        [
            allProfileStackView
        ].forEach {
            view.addSubview($0)
        }
        
        allProfileStackView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(16)
        }
    }
}
