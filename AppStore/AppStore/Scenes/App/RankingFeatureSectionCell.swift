//
//  RankingFeatureSectionCell.swift
//  AppStore
//
//  Created by 강태준 on 2022/08/28.
//

import UIKit
import SnapKit


final class RankingFeatureSectionCell: UICollectionViewCell {
    private var rankingFeatureList = [RankingFeature]()
    private let separator = SeparatorView()
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(RankingFeatureSectionCollectionViewCell.self, forCellWithReuseIdentifier: "RankingFeatureSectionCollectionViewCell")
        collectionView.register(RankingFeatureSectionCollectionViewHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "RankingFeatureSectionCollectionViewHeader")
        
        return collectionView
    }()
    
    func setup() {
        setupLayout()
        fetchData()
        collectionView.reloadData()
    }
}


private extension RankingFeatureSectionCell {
    func fetchData() {
        guard let url = Bundle.main.url(forResource: "RankingFeature", withExtension: "plist")
        else {
            return
        }
        
        let decoder = PropertyListDecoder()
        
        do {
            let data = try Data(contentsOf: url)
            rankingFeatureList = try decoder.decode([RankingFeature].self, from: data)
        } catch {
            print("ERROR: \(String(describing: error.localizedDescription))")
        }
    }
    
    func setupLayout() {
        [
            collectionView,
            separator
        ].forEach {
            addSubview($0)
        }
        
        collectionView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(RankingFeatureSectionCollectionViewCell.height * 3)
            $0.top.equalToSuperview()
        }
        
        separator.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
            $0.top.equalTo(collectionView.snp.bottom).offset(8)
        }
    }
}


extension RankingFeatureSectionCell: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return rankingFeatureList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RankingFeatureSectionCollectionViewCell", for: indexPath) as? RankingFeatureSectionCollectionViewCell
        else {
            return UICollectionViewCell()
        }
        
        cell.setup(rankingFeature: rankingFeatureList[indexPath.row])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width
        let height = RankingFeatureSectionCollectionViewCell.height
        return CGSize(width: width, height: height)
    }
}

