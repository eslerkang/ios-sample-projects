//
//  StationInfoViewController.swift
//  SubwayStation
//
//  Created by 강태준 on 2022/08/29.
//

import UIKit
import SnapKit


final class StationInfoViewController: UIViewController {
    private lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(fetchData), for: .valueChanged)
        
        return refreshControl
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.refreshControl = refreshControl
        collectionView.register(StationInfoCollectionViewCell.self, forCellWithReuseIdentifier: "stationInfoCell")
        
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigation()
        setupLayout()
    }
}


private extension StationInfoViewController {
    @objc func fetchData() {
        print("hihi")
        refreshControl.endRefreshing()
    }
    
    func setupNavigation() {
        navigationItem.title = "왕십리"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func setupLayout() {
        [
            collectionView
        ].forEach {
            view.addSubview($0)
        }
        
        collectionView.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalToSuperview()
        }
    }
}


extension StationInfoViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "stationInfoCell", for: indexPath) as? StationInfoCollectionViewCell
        else {
            return UICollectionViewCell()
        }
        
        cell.setup()
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width - 32
        return CGSize(width: width, height: 100)
    }
}
