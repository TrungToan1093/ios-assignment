//
//  FetchDataService.swift
//  Assignment
//
//  Created by ToanHT on 21/02/2022.
//

import Foundation

class FetchDataService {
    static let shared: FetchDataService = FetchDataService()
    private init(){}
    
    let citiesJsonName: String = "cities"
    
    func fetchInitData() -> [CityModel] {
        if let localData = Helper.readLocalFile(forName: citiesJsonName),
           let model: [CityModel] = Helper.parseArray(jsonData: localData) {
            return model
        }
        return []
    }
}
