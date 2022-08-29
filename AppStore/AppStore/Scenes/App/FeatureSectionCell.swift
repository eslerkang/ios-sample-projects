//
//  FeatureSectionCell.swift
//  AppStore
//
//  Created by 강태준 on 2022/08/28.
//

import UIKit
import SnapKit


final class FeatureSectionCell: UICollectionViewCell {
    private var featureList = [Feature]()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 32
        layout.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        
        collectionView.register(FeatureSectionCollectionViewCell.self, forCellWithReuseIdentifier: "FeatureSectionCollectionViewCell")
        
        return collectionView
    }()
    private let separator = SeparatorView()
    
    func setup() {
        setupLayout()
        fetchData()
        collectionView.reloadData()
    }
}


private extension FeatureSectionCell {
    func fetchData() {
        guard let url = Bundle.main.url(forResource: "Feature", withExtension: "plist")
        else {
            return
        }
        
        let decoder = PropertyListDecoder()
        
        do {
            let data = try Data(contentsOf: url)
            featureList = try decoder.decode([Feature].self, from: data)
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
            $0.top.equalToSuperview()
            $0.height.equalTo(snp.width)
        }
        
        separator.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalTo(collectionView.snp.bottom).offset(8)
            $0.bottom.equalToSuperview()
        }
    }
}


extension FeatureSectionCell: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return featureList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FeatureSectionCollectionViewCell", for: indexPath) as? FeatureSectionCollectionViewCell
        else {
            return UICollectionViewCell()
        }
        
        cell.setup(feature: featureList[indexPath.row])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width - 32
        return CGSize(width: width, height: width)
    }
}
