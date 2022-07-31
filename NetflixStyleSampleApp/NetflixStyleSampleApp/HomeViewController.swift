//
//  HomeViewController.swift
//  NetflixStyleSampleApp
//
//  Created by 강태준 on 2022/07/30.
//

import UIKit
import SnapKit

class HomeViewController: UICollectionViewController {
    var contents: [Content] = []
    let contentCollectionViewCellIdentifier = "ContentCollectionViewCell"
    let contentCollectionViewHeaderIdentifier = "ContentCollectionViewHeader"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigationController()
        
        contents = getContents()
        
        collectionView.register(
            ContentCollectionViewCell.self,
            forCellWithReuseIdentifier: contentCollectionViewCellIdentifier
        )
        collectionView.register(
            ContentCollectionViewHeader.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: contentCollectionViewHeaderIdentifier
        )
    }
    
    private func configureNavigationController() {
        navigationController?.navigationBar.backgroundColor = .clear
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.hidesBarsOnSwipe = true
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(imageLiteralResourceName: "netflix_icon"), style: .plain, target: nil, action: nil)
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "person.crop.circle"), style: .plain, target: nil, action: nil)
    }
    
    func getContents() -> [Content] {
        guard let path = Bundle.main.path(forResource: "Content", ofType: "plist"),
              let data = FileManager.default.contents(atPath: path),
              let list = try? PropertyListDecoder().decode([Content].self, from: data)
        else {
            return []
        }
        
        return list
    }
}


// UICollectionView Datasource, Delegate
extension HomeViewController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch contents[section].sectionType {
        case .main:
            return 1
        default:
            return contents[section].contentItem.count
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch contents[indexPath.section].sectionType {
        case .basic, .large:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: contentCollectionViewCellIdentifier, for: indexPath) as? ContentCollectionViewCell else {return UICollectionViewCell()}
            cell.imageView.image = contents[indexPath.section].contentItem[indexPath.row].image
            return cell
        default:
            return UICollectionViewCell()
        }
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return contents.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let sectionName = contents[indexPath.section].sectionName
        print("TEST: \(sectionName)섹션의 \(indexPath.row+1)번째 항목 선택")
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: contentCollectionViewHeaderIdentifier, for: indexPath) as? ContentCollectionViewHeader else {fatalError("Could not dequeue header")}
            headerView.sectionNameLabel.text = contents[indexPath.section].sectionName
            return headerView
        } else {
            return UICollectionReusableView()
        }
    }
}
