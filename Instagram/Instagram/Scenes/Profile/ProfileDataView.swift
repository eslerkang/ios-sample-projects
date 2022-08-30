//
//  ProfileDataView.swift
//  Instagram
//
//  Created by 강태준 on 2022/08/30.
//

import UIKit
import SnapKit


final class ProfileDataView: UIView {
    private let title: String
    private let data: Int
    
    private lazy var dataLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .bold)
        label.text = "\(data)"
        
        return label
    }()
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.text = title
        
        return label
    }()
    
    init(title: String, data: Int) {
        self.title = title
        self.data = data
        
        super.init(frame: .zero)
        
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


private extension ProfileDataView {
    func setupLayout() {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        stackView.spacing = 4
        
        [
            dataLabel,
            titleLabel
        ].forEach {
            stackView.addArrangedSubview($0)
        }
        
        addSubview(stackView)
        
        stackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
