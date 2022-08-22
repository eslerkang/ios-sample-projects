//
//  Asset.swift
//  MyAsset
//
//  Created by 강태준 on 2022/08/22.
//

import Foundation


class Asset: ObservableObject, Codable, Identifiable {
    let id: Int
    let type: AssetMenu
    let data: [AssetData]
    
    init(id: Int, type: AssetMenu, data: [AssetData]) {
        self.id = id
        self.type = type
        self.data = data
    }
}


class AssetData: Identifiable, ObservableObject, Codable {
    let id: Int
    let title: String
    let amount: String
    
    init(id: Int, title: String, amount: String) {
        self.id = id
        self.title = title
        self.amount = amount
    }
}
