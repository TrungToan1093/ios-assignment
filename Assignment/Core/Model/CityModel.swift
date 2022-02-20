//
//  CityModel.swift
//  Test
//
//  Created by ToanHT on 18/02/2022.
//

import Foundation

/**
 [CityModel] => [SearchCityModel]
 data seach có dạng: [String: SearchCityModel]
 */

struct CityModel: Codable {
    var country: String
    var name: String
    var _id: Int64
    var coord: CoordinateModel
}

extension CityModel: Hashable {
    static func ==(lhs: CityModel, rhs: CityModel) -> Bool {
        return lhs._id == rhs._id && lhs.name == rhs.name && lhs.country == rhs.country && lhs.coord == rhs.coord
    }
}

//extension CityModel: Hashable {
//    static func == (lhs: CityModel, rhs: CityModel) -> Bool {
//        return lhs._id == rhs._id
//    }
//}

struct CoordinateModel: Codable {
    var lon: Double
    var lat: Double
}

extension CoordinateModel: Hashable {
    static func ==(lhs: CoordinateModel, rhs: CoordinateModel) -> Bool {
        return lhs.lon == rhs.lon && lhs.lat == rhs.lat
    }
}

struct SearchCityModel: Codable {
    var key: String
    var value: [CityModel]
    var related: [String: SearchCityModel]
    
    mutating func updateRelated(related: [String: SearchCityModel]) {
        self.related = related
    }
    
    mutating func updateValue(_ data: [CityModel]) {
        self.value = data
    }
}
