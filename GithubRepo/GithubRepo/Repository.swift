//
//  Repository.swift
//  GithubRepo
//
//  Created by 강태준 on 2022/08/31.
//

import Foundation


struct Repository: Decodable {
    let id: Int
    let name: String
    let description: String?
    let language: String?
    let star: Int
    
    enum CodingKeys: String, CodingKey {
        case id, name, description, language
        case star = "stargazers_count"
    }
}
