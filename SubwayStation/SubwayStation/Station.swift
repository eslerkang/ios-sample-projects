//
//  Station.swift
//  SubwayStation
//
//  Created by 강태준 on 2022/08/29.
//

import Foundation


struct StationResponseModel: Decodable {
    var stations: [Station] {
        searchInfo.row
    }
    
    private let searchInfo: StationNameServiceModel
    
    enum CodingKeys: String, CodingKey {
        case searchInfo = "SearchInfoBySubwayNameService"
    }
    
    struct StationNameServiceModel: Decodable {
        let row: [Station]
    }
}


struct Station: Decodable {
    let stationName: String
    let lineNumber: String
    
    enum CodingKeys: String, CodingKey {
        case stationName = "STATION_NM"
        case lineNumber = "LINE_NUM"
    }
}
