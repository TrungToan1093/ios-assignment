//
//  SearchService+City.swift
//  Assignment
//
//  Created by ToanHT on 18/02/2022.
//

import Foundation
protocol SearchCityProtocol {
    var citisOriginal: [CityModel] { get }
    func search(text: String, completion: @escaping (([CityModel]) -> Void))
}

class SearchDefaultImplement: SearchCityProtocol {
    
    var citisOriginal: [CityModel]
    var currentSearchCityModel: [String: SearchCityModel] = DictionaryService.shared.searchCityModel
    init(cities: [CityModel]) {
        self.citisOriginal = cities
    }
    
    func search(text: String, completion: @escaping (([CityModel]) -> Void)) {
        if text.isEmpty {
            completion(citisOriginal)
        } else {
            self.searchFromName(text: text) { data in
                completion(data)
            }
        }
    }
    
    private func searchFromName(text: String, completion: (([CityModel]) -> Void)) {
        if  let data = self.currentSearchCityModel[text.lowercased()] {
            completion(data.value)
        } else {
            completion([])
        }
    }
}


class SearchSufixImplement: SearchCityProtocol {
    
    var citisOriginal: [CityModel]
    var currentSearchCityModel: [String: SearchCityModel] = SuffixReferenceService.shared.relaredModel
    var currentSearchCountryModel: [String: SearchCityModel] = SuffixReferenceService.shared.relaredCountryModel
    
    init(cities: [CityModel]) {
        self.citisOriginal = cities
    }
    
    func search(text: String, completion: @escaping (([CityModel]) -> Void)) {
        if text.isEmpty {
            completion(self.citisOriginal)
        } else {
            self.searchFromName(text: text) { data in
                completion(data)
            }
        }
    }
    
    private func searchFromName(text: String, completion: @escaping (([CityModel]) -> Void)) {
        let textLowercased = text.lowercased()
        let group = DispatchGroup()
        var citiesWithName: [CityModel] = []
        group.enter()
        self.searchFromCity(text: textLowercased) { cities in
            citiesWithName = cities
            group.leave()
        }
        
        group.enter()
        var citiesWithCountry: [CityModel] = []
        self.searchFromCountry(text: textLowercased) { cities in
            citiesWithCountry = cities
            group.leave()
        }
        
        group.notify(queue: .main) {
            let data: [CityModel] = (citiesWithName + citiesWithCountry).removingDuplicates()
            completion(data)
        }
    }
    
    
    
    func searchFromCity(text: String, completion: (([CityModel]) -> Void)) {
        var resultSearch: SearchCityModel?
        for index in 1...text.count {
            let query = text[0..<index]
            resultSearch = self.handlerSearchWithName(key: query, dataForSearch: resultSearch?.related ?? currentSearchCityModel)
        }
        
        if let data = resultSearch?.value {
            completion(data)
        } else {
            completion([])
        }
        
    }
    
    func searchFromCountry(text: String, completion: (([CityModel]) -> Void)) {
        var resultSearch: SearchCityModel?
        for index in 1...text.count {
            let query = text[0..<index]
            resultSearch = self.handlerSearchWithName(key: query, dataForSearch: resultSearch?.related ?? currentSearchCountryModel)
        }
        
        if let data = resultSearch?.value {
            completion(data)
        } else {
            completion([])
        }
    }
    
    
    func handlerSearchWithName(key: String, dataForSearch: [String: SearchCityModel]) -> SearchCityModel? {
        return dataForSearch[key]
    }
}
