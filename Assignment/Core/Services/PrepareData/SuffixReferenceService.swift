//
//  SuffixReferencePrepareData.swift
//  Assignment
//
//  Created by ToanHT on 21/02/2022.
//

import Foundation

class SuffixReferenceService {
    static let shared: SuffixReferenceService = SuffixReferenceService()
    
    public private(set) var cities: [CityModel] = []
    public private(set) var relaredModel: [String: SearchCityModel] = [:]
    public private(set) var relaredCountryModel: [String: SearchCityModel] = [:]
    
    private init(){}
    
    func loadData(_ completion: (Bool) -> ()) {
        self.setupData()
        completion(true)
    }
    
    private func setupData() {
        let initModel = FetchDataService.shared.fetchInitData()
        self.cities = self.sortData(cities: initModel)
        self.prepareRelatedData()
    }
    
    private func sortData(cities: [CityModel]) -> [CityModel] {
        let citiesSort = cities.sorted { $0.name.lowercased() < $1.name.lowercased() }
        return citiesSort
    }
    
    private func prepareRelatedData() {
        let groupName = Dictionary.init(grouping: cities) { (item) -> String in
            return String(item.name.lowercased().first!)
        }
        groupName.forEach { (key, value) in
            self.handlerRelatedCitydData(key: key, cities: value, related: &self.relaredModel)
        }

        let groupCountry = Dictionary.init(grouping: cities) { (item) -> String in
            return String(item.country.lowercased().first!)
        }
        groupCountry.forEach { (key, value) in
            self.handlerRelatedCountryData(key: key, cities: value, related: &self.relaredCountryModel)
        }
    }
    
    private func handlerRelatedCitydData(key: String, cities: [CityModel], related: inout [String: SearchCityModel]) {
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
        self.updateRelatedData(key: key, value: cities, group: group, searchCityModel: &related)
        guard group.count > 0 else { return }
        group.forEach { (newkey, value) in
            if (value.count == 1 && key == value[0].name) || key.isEmpty {
                return
            } else {
                if related[key]?.related != nil {
                    self.handlerRelatedCitydData(key: newkey, cities: value, related: &related[key]!.related)
                }
            }
        }
    }
    
    private func handlerRelatedCountryData(key: String, cities: [CityModel], related: inout [String: SearchCityModel]) {
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
        self.updateRelatedData(key: key, value: cities, group: group, searchCityModel: &related)
        guard group.count > 0 else { return }
        group.forEach { (newkey, value) in
            if (value.count == 1 && key == value[0].country) || key.isEmpty {
                return
            } else {
                if related[key]?.related != nil {
                    self.handlerRelatedCountryData(key: newkey, cities: value, related: &related[key]!.related)
                }
            }
        }
    }
    
    private func updateRelatedData(key: String, value: [CityModel], group: [String : [CityModel]], searchCityModel: inout [String: SearchCityModel]) {
        var related: [String: SearchCityModel] = [:]
        group.forEach { (k, v) in
            let searchModel: SearchCityModel = SearchCityModel(key: k, value: v, related: [:])
            related[k] = searchModel
        }
        
        let model = SearchCityModel(key: key, value: value, related: related)
        searchCityModel[key] = model
    }
}

