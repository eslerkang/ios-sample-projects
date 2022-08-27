//
//  FeatureSectionView.swift
//  AppStore
//
//  Created by 강태준 on 2022/08/27.
//

import UIKit
import SnapKit


final class FeatureSectionView: UIView {
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
    }()
}
