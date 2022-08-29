//
//  StationArrival.swift
//  SubwayStation
//
//  Created by 강태준 on 2022/08/29.
//

import Foundation


struct StationArrivalResponseModel: Decodable {
    let realtimeArrivalList: [RealTimeArrival]
}

struct RealTimeArrival: Decodable {
    let lineName: String
    let remainTime: String
    let currentLocation: String
    
    enum CodingKeys: String, CodingKey {
        case lineName = "trainLineNm"
        case remainTime = "arvlMsg2"
        case currentLocation = "arvlMsg3"
    }
}
