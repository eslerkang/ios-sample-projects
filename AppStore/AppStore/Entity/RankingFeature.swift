//
//  RankingFeature.swift
//  AppStore
//
//  Created by 강태준 on 2022/08/28.
//

import Foundation


struct RankingFeature: Decodable {
    let title: String
    let description: String
    let isInPurchaseApp: Bool
}
