//
//  Feature.swift
//  AppStore
//
//  Created by 강태준 on 2022/08/28.
//

import Foundation


struct Feature: Decodable {
    let type: String
    let appName: String
    let description: String
    let imageURL: String
}
