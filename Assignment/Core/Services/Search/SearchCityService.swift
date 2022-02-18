//
//  SearchService+City.swift
//  Assignment
//
//  Created by ToanHT on 18/02/2022.
//

import Foundation


protocol SearchCityProtocol {
    var citisOriginal: [CityModel] { get }
    func search(text: String, completion: (([CityModel]) -> Void))
}

class SearchDefaultImplement: SearchCityProtocol {
    var citisOriginal: [CityModel]
    var currentSearch: [String: SearchCityModel]
    var tempSearch: [String: SearchCityModel]
    init(cities: [CityModel], currentSearch: [String: SearchCityModel]) {
        self.citisOriginal = cities
        self.currentSearch = currentSearch
        self.tempSearch = currentSearch
    }
    
    func search(text: String, completion: (([CityModel]) -> Void)) {
        if text.isEmpty {
            completion(citisOriginal)
        } else {
            
//            let search = self.groupData()
            let search = self.search(text: text)
            completion(search)
        }
    }
    
    func seperater(text: String) {
        let listChar = Array(text)
        
    }
    
    private func search(text: String) -> [CityModel] {
        if  let data = self.tempSearch[text.lowercased()] {
            self.tempSearch = data.related
            return data.value
        } else {
            return []
        }
    }
    
    func searchWithChar(char: Character) {
        
    }
    
    func groupData() -> [CityModel] {
        
        let groupName = Dictionary(grouping: self.citisOriginal) { (city) -> String in
            return String(city.name.lowercased().first!)
        }
        return groupName["b"]!
        
    }
}
