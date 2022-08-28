//
//  AppViewControllerByCollectionView.swift
//  AppStore
//
//  Created by 강태준 on 2022/08/28.
//

import UIKit
import SnapKit


final class AppViewControllerByCollectionView: UIViewController {
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .systemBackground
        
        collectionView.register(FeatureSectionCell.self, forCellWithReuseIdentifier: "FeatureSectionCell")
        collectionView.register(RankingFeatureSectionCell.self, forCellWithReuseIdentifier: "RankingFeatureSectionCell")
        
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        setupLayout()
    }
}


private extension AppViewControllerByCollectionView {
    func setupLayout() {
        [
            collectionView
        ].forEach {
            view.addSubview($0)
        }
        
        collectionView.snp.makeConstraints {
            $0.bottom.leading.trailing.equalToSuperview()
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
        }
    }
}


extension AppViewControllerByCollectionView: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.row {
        case 0:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FeatureSectionCell", for: indexPath) as? FeatureSectionCell
            else {
                return UICollectionViewCell()
            }
            
            return cell
            
        case 1:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RankingFeatureSectionCell", for: indexPath) as? RankingFeatureSectionCell
            else {
                return UICollectionViewCell()
            }
            
            return cell
            
        default:
            return UICollectionViewCell()
        }
    }
}
