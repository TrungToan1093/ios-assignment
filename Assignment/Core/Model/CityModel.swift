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

struct CoordinateModel: Codable {
    var lon: Double
    var lat: Double
}

struct SearchCityModel: Codable {
    var key: String
    var value: [CityModel]
    var related: [String: SearchCityModel]
    
    mutating func updateRelated(related: [String: SearchCityModel]) {
        self.related = related
    }
    
    mutating func updateValue(_ data: [CityModel]) {
        self.value += data
    }
}
