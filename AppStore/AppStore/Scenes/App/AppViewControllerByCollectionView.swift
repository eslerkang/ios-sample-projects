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
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .systemBackground
        
        collectionView.register(FeatureSectionCell.self, forCellWithReuseIdentifier: "FeatureSectionCell")
        collectionView.register(RankingFeatureSectionCell.self, forCellWithReuseIdentifier: "RankingFeatureSectionCell")
        collectionView.register(ExchangeCodeFooter.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "ExchangeCodeFooter")
        
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        setupNavigationController()
        setupLayout()
    }
}


private extension AppViewControllerByCollectionView {
    func setupNavigationController() {
        navigationItem.title = "앱"
        navigationItem.largeTitleDisplayMode = .always
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
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
            
            cell.setup()
            
            return cell
            
        case 1:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RankingFeatureSectionCell", for: indexPath) as? RankingFeatureSectionCell
            else {
                return UICollectionViewCell()
            }
            
            cell.setup()

            return cell
        default:
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width: CGFloat = collectionView.frame.width

        switch indexPath.row {
        case 0:
            return CGSize(width: width, height: width)
        case 1:
            return CGSize(width: width, height: 280)
        default:
            return CGSize(width: width, height: 200)
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard kind == UICollectionView.elementKindSectionFooter,
              let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "ExchangeCodeFooter", for: indexPath) as? ExchangeCodeFooter
        else {
            return UICollectionReusableView()
        }
        
        footer.setup()
        
        return footer
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        let width = collectionView.frame.width
        return CGSize(width: width, height: 200)
    }
}
