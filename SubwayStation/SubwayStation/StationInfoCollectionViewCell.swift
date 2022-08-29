//
//  StationInfoCollectionViewCell.swift
//  SubwayStation
//
//  Created by 강태준 on 2022/08/29.
//

import UIKit
import SnapKit


final class StationInfoCollectionViewCell: UICollectionViewCell {
    private lazy var lineLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .bold)
        
        return label
    }()
    private lazy var remainTimeLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .medium)
        
        return label
    }()
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        
        [
            lineLabel,
            remainTimeLabel
        ].forEach {
            stackView.addArrangedSubview($0)
        }
        
        return stackView
    }()
    
    func setup(realTimeArrival: RealTimeArrival) {
        setupLayout()
        
        layer.cornerRadius = 12
        layer.shadowRadius = 10
        layer.shadowColor = UIColor.gray.cgColor
        layer.shadowOpacity = 0.5
        backgroundColor = .systemBackground
        
        lineLabel.text = realTimeArrival.lineName
        remainTimeLabel.text = realTimeArrival.remainTime
    }
}


private extension StationInfoCollectionViewCell {
    func setupLayout() {
        addSubview(stackView)
        
        stackView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(16)
        }
    }
}
