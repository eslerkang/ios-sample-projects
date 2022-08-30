//
//  FeedTableViewCell.swift
//  Instagram
//
//  Created by 강태준 on 2022/08/30.
//

import UIKit
import SnapKit


final class FeedTableViewCell: UITableViewCell {
    private lazy var postImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .gray
        
        return imageView
    }()
    
    private lazy var likeButton: UIButton = {
        let button = UIButton()
        button.setImage(systemName: "heart")
        
        return button
    }()
    private lazy var commentButton: UIButton = {
        let button = UIButton()
        button.setImage(systemName: "message")
        
        return button
    }()
    private lazy var directMessageButon: UIButton = {
        let button = UIButton()
        button.setImage(systemName: "paperplane")
        
        return button
    }()
    private lazy var leftButtonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        stackView.spacing = 12
        
        [
            likeButton,
            commentButton,
            directMessageButon
        ].forEach {
            stackView.addArrangedSubview($0)
        }
        
        return stackView
    }()
    
    private lazy var bookmarkButton: UIButton = {
        let button = UIButton()
        button.setImage(systemName: "bookmark")
        
        return button
    }()
    private lazy var rightButtonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        stackView.spacing = 12
        
        [
            bookmarkButton
        ].forEach {
            stackView.addArrangedSubview($0)
        }
        
        return stackView
    }()
    
    private lazy var buttonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        
        [
            leftButtonStackView,
            rightButtonStackView
        ].forEach {
            stackView.addArrangedSubview($0)
        }
        
        return stackView
    }()
    
    private lazy var likeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .systemFont(ofSize: 13, weight: .semibold)
        label.text = "홍길동님 외 32명이 좋아합니다"
        
        return label
    }()
    private lazy var contentLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.numberOfLines = 5
        label.font = .systemFont(ofSize: 13, weight: .medium)
        label.text = "반짝이는 용감하고 우리 열락의 거선의 뜨거운지라, 대한 같지 이상은 때문이다. 투명하되 살 그와 천자만홍이 목숨을 역사를 군영과 아름답고 끝까지 이것이다. 커다란 같지 끓는 인생의 새 그리하였는가? 곧 이는 얼음 남는 봄바람이다. 밥을 따뜻한 부패를 피어나기 전인 능히 청춘의 그리하였는가? 인생에 따뜻한 유소년에게서 끓는다. 않는 천고에 그들은 품으며, 사라지지 피부가 부패뿐이다. 가치를 것은 같지 무엇이 철환하였는가? 길지 쓸쓸한 있는 이것을 것이다. 커다란 그들의 영락과 꾸며 어디 너의 봄바람이다."
        
        return label
    }()
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .secondaryLabel
        label.font = .systemFont(ofSize: 13, weight: .medium)
        label.text = "1일전"
        
        return label
    }()
    private lazy var contentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .equalSpacing
        stackView.spacing = 8
        
        [
            buttonStackView,
            likeLabel,
            contentLabel,
            dateLabel
        ].forEach {
            stackView.addArrangedSubview($0)
        }
        
        return stackView
    }()
    
    func setup() {
        [
            likeButton,
            commentButton,
            directMessageButon,
            bookmarkButton
        ].forEach {
            $0.snp.makeConstraints {
                let width = 20
                $0.width.equalTo(width)
                $0.height.equalTo(width)
            }
        }
        
        [
            postImageView,
            contentStackView
        ].forEach {
            addSubview($0)
        }
        
        postImageView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(postImageView.snp.width)
        }
        contentStackView.snp.makeConstraints {
            $0.top.equalTo(postImageView.snp.bottom).offset(16)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview().inset(16)
        }
    }
}
