//
//  Alert.swift
//  Drink
//
//  Created by 강태준 on 2022/07/26.
//

import Foundation

struct Alert: Codable {
    var id: String = UUID().uuidString
    let date: Date
    var isOn: Bool
    
    var time: String {
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "hh:mm"
        return timeFormatter.string(from: date)
    }
    
    var merdiem: String {
        let merdiemFormatter = DateFormatter()
        merdiemFormatter.dateFormat = "a"
        merdiemFormatter.locale = Locale(identifier: "ko")
        return merdiemFormatter.string(from: date)
    }
}
