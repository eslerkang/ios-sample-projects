//
//  HomeViewController.swift
//  NetflixStyleSampleApp
//
//  Created by 강태준 on 2022/07/30.
//

import UIKit
import SwiftUI

class HomeViewController: UICollectionViewController {
    var contents: [Content] = []
    let cellIdentifier = "ContentCollectionViewCell"
    let headerIdentifier = "ContentCollectionViewHeader"
    let rankCellIdentifier = "ContentCollectionViewRankCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigationController()
        
        contents = getContents()
        
        collectionView.backgroundColor = .black
        collectionView.register(
            ContentCollectionViewCell.self,
            forCellWithReuseIdentifier: cellIdentifier
        )
        collectionView.register(
            ContentCollectionViewHeader.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: headerIdentifier
        )
        collectionView.register(
            ContentCollectionViewRankCell.self,
            forCellWithReuseIdentifier: rankCellIdentifier
        )
        
        collectionView.collectionViewLayout = layout()
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
    
    // 각 섹션 타입에 대한 UICollectionViewLayout 생성
    private func layout() -> UICollectionViewLayout {
        return UICollectionViewCompositionalLayout { [weak self] sectionNumber, environment -> NSCollectionLayoutSection? in
            guard let self = self else {return nil}
            
            switch self.contents[sectionNumber].sectionType {
            case .basic:
                return self.createBasicTypeSection()
            case .large:
                return self.createLargeTypeSection()
            case .rank:
                return self.createRankTypeSection()
            default:
                return nil
            }
        }
    }
    
    private func createBasicTypeSection() -> NSCollectionLayoutSection {
        // create item
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(0.3),
            heightDimension: .fractionalHeight(0.75)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = .init(top: 10, leading: 5, bottom: 0, trailing: 5)
        
        // create group
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.9), heightDimension: .estimated(200))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 3)
        
        // create section
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = .init(top: 0, leading: 5, bottom: 0, trailing: 5)
        
        let sectionHeader = self.createSectionHeader()
        section.boundarySupplementaryItems = [sectionHeader]
        
        return section
    }
    
    // 큰 화면 Section Layout Setting
    private func createLargeTypeSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(0.3),
            heightDimension: .fractionalHeight(0.75)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = .init(top: 10, leading: 5, bottom: 0, trailing: 5)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(0.9),
            heightDimension: .estimated(400)
        )
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 2)
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = .init(top: 0, leading: 5, bottom: 0, trailing: 5)
        
        let sectionHeader = self.createSectionHeader()
        section.boundarySupplementaryItems = [sectionHeader]
        
        return section
    }
    
    // Rank Section Layout Section
    private func createRankTypeSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(0.3),
            heightDimension: .fractionalHeight(0.9)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = .init(top: 10, leading: 5, bottom: 0, trailing: 5)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(0.9),
            heightDimension: .estimated(200)
        )
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 2)
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = .init(top: 0, leading: 5, bottom: 0, trailing: 5)
        
        let sectionHeader = createSectionHeader()
        section.boundarySupplementaryItems = [sectionHeader]
        
        return section
    }
    
    // sectionHeader layout setting
    private func createSectionHeader() -> NSCollectionLayoutBoundarySupplementaryItem {
        // Section Header Size
        let layoutSectionHeaderSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(30))
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: layoutSectionHeaderSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        
        return sectionHeader
    }
}


// UICollectionView Datasource, Delegate
extension HomeViewController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if contents[section].sectionType == .basic
            || contents[section].sectionType == .large
            || contents[section].sectionType == .rank {
            switch contents[section].sectionType {
            case .main:
                return 1
            default:
                return contents[section].contentItem.count
            }
        }
        return 0
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch contents[indexPath.section].sectionType {
        case .basic, .large:
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: cellIdentifier,
                for: indexPath
            ) as? ContentCollectionViewCell else {return UICollectionViewCell()}
            cell.imageView.image = contents[indexPath.section].contentItem[indexPath.row].image
            return cell
        case .rank:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: rankCellIdentifier, for: indexPath) as? ContentCollectionViewRankCell else {return UICollectionViewCell()}
            cell.imageView.image = contents[indexPath.section].contentItem[indexPath.row].image
            cell.rankLabel.text = String(describing: indexPath.row + 1)
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
            guard let headerView = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: headerIdentifier,
                for: indexPath
            ) as? ContentCollectionViewHeader else {fatalError("Could not dequeue header")}
            headerView.sectionNameLabel.text = contents[indexPath.section].sectionName
            return headerView
        } else {
            return UICollectionReusableView()
        }
    }
}


// SwiftUI Preview
struct HomeViewController_Preview: PreviewProvider {
    static var previews: some View {
        Container().edgesIgnoringSafeArea(.all)
    }
    
    struct Container: UIViewControllerRepresentable {
        func makeUIViewController(context: Context) -> UIViewController {
            let layout = UICollectionViewLayout()
            let homeViewController = HomeViewController(collectionViewLayout: layout)
            return UINavigationController(rootViewController: homeViewController)
        }
        
        func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
            print("updated")
        }
        
        typealias UIViewControllerType = UIViewController
    }
}
