//
//  DictionaryPrepareData.swift
//  Assignment
//
//  Created by ToanHT on 21/02/2022.
//

import Foundation

class DictionaryService {
    static let shared: DictionaryService = DictionaryService()
    init() { }
    
    public private(set) var cities: [CityModel] = []
    public private(set) var searchCityModel: [String: SearchCityModel] = [:]
    
    func loadData(_ completion: (Bool) -> ()) {
        self.setupData()
        completion(true)
        
    }
    private func setupData() {
        let initModel = FetchDataService.shared.fetchInitData()
        self.cities = self.sortData(cities: initModel)
        self.prepareData()
    }
    
    private func sortData(cities: [CityModel]) -> [CityModel] {
        let citiesSort = cities.sorted { $0.name.lowercased() < $1.name.lowercased() }
        return citiesSort
    }
    
    private func prepareData() {
        let groupName = Dictionary.init(grouping: cities) { (item) -> String in
            return String(item.name.lowercased().first!)
        }
        groupName.forEach { (key, value) in
            self.handlerCitiesNameData(key: key, cities: value)
        }
        
        let groupCountry = Dictionary.init(grouping: cities) { (item) -> String in
            return String(item.country.lowercased().first!)
        }
        groupCountry.forEach { (key, value) in
            self.handlerCitiesCountryData(key: key, cities: value)
        }

    }
    private func handlerCitiesCountryData(key: String, cities: [CityModel]) {
        let group = Dictionary.init(grouping: cities) { (item) -> String in
            if key.count < item.country.count {
                let string = (key + item.country[key.count]).lowercased()
                return string
            } else {
                return ""
            }
        }.filter {
            $0.key != ""
        }
        self.updateRelatedCityData(key: key, value: cities, group: group, searchCityModel:  &self.searchCityModel)
        guard group.count > 0 else { return }
        group.forEach { (key, value) in
            if (value.count == 1 && key == value[0].country) || key.isEmpty {
                return
            } else {
                self.handlerCitiesCountryData(key: key, cities: value)
            }
        }
    }
    
    private func handlerCitiesNameData(key: String, cities: [CityModel]) {
        let group = Dictionary.init(grouping: cities) { (item) -> String in
            if key.count < item.name.count {
                let string = (key + item.name[key.count]).lowercased()
                return string
            } else {
                return ""
            }
        }.filter {
            $0.key != ""
        }
        self.updateRelatedCityData(key: key, value: cities, group: group, searchCityModel:  &self.searchCityModel)
        guard group.count > 0 else { return }
        group.forEach { (key, value) in
            if (value.count == 1 && key == value[0].name) || key.isEmpty {
                return
            } else {
                self.handlerCitiesNameData(key: key, cities: value)
            }
        }
    }
    
    private func updateRelatedCityData(key: String, value: [CityModel], group: [String : [CityModel]], searchCityModel: inout [String: SearchCityModel]) {
        let model = SearchCityModel(key: key, value: value, related: [:])
        
        if let oldData = searchCityModel[key] {
            let newData = (oldData.value + value).removingDuplicates()
            searchCityModel[key]?.updateValue(newData)
        }
        searchCityModel[key] = model
    }
}
