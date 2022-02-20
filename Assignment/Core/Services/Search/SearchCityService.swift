//
//  SearchService+City.swift
//  Assignment
//
//  Created by ToanHT on 18/02/2022.
//

import Foundation


class SearchService {
    static let shared: SearchService = SearchService()
    private init(){}
    
    let citiesJsonName: String = "cities"
    public private(set) var cities: [CityModel] = []
    public private(set) var searchCityModel: [String: SearchCityModel] = [:]
    public private(set) var searchCountryModel: [String: SearchCityModel] = [:]
    
    func loadData(_ completion: (Bool) -> ()) {
        self.setupData()
        completion(true)
    }
    
    private func setupData() {
        let initModel = self.fetchInitData()
        self.cities = self.sortData(cities: initModel)
        self.prepareData()
//        self.prepareGroupData()
    }
    
    private func fetchInitData() -> [CityModel] {
        if let localData = Helper.readLocalFile(forName: citiesJsonName),
           let model: [CityModel] = Helper.parseArray(jsonData: localData) {
            return model
        }
        return []
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
    
    func prepareGroupData() {
        let groupName = Dictionary.init(grouping: self.searchCityModel) { (item) -> String in
            return item.key[0]
        }
        groupName.forEach { (key, value) in
            var relatedData: [String: SearchCityModel] = [:]
            value.forEach { (key: String, value: SearchCityModel) in
                relatedData[key] = value
            }
            self.groupDict(key: key, data: relatedData, dataUpdateNeed: &self.searchCityModel)
        }
    }
    
    
    private func groupDict(key: String, data: [String: SearchCityModel], dataUpdateNeed: inout [String: SearchCityModel]) {
        guard var releatedUpdateNeed = dataUpdateNeed[key]?.related else { return }
        var dataUpdateNeed: [String: SearchCityModel] = [:]
        let group = Dictionary.init(grouping: data) { (item) -> String in
            if key.count < item.key.count {
                let string = (key + item.key[key.count]).lowercased()
                return string
            } else {
                return ""
            }
        }.filter {
            $0.key != ""
        }
        guard group.count > 0 else { return }
        group.forEach { (key, value) in
            var relatedData: [String: SearchCityModel] = [:]
            value.forEach { (key: String, value: SearchCityModel) in
                relatedData[key] = value
            }
            dataUpdateNeed[key]?.updateRelated(related: relatedData)
            if relatedData.count == 1 && key == relatedData[key]?.key || key.isEmpty {
                return
            } else {
                self.groupDict(key: key, data: relatedData, dataUpdateNeed: &releatedUpdateNeed)
            }
        }
    }
    
    private func updateRelatedCityData(key: String, value: [CityModel], group: [String : [CityModel]], searchCityModel: inout [String: SearchCityModel]) {
//        var data: [String: SearchCityModel] = [:]
//        group.forEach { (k, v) in
//            let searchModel: SearchCityModel = SearchCityModel(key: k, value: v, related: [:])
//            data[k] =  searchModel
//        }
        let model = SearchCityModel(key: key, value: value, related: [:])
        
        if let oldData = searchCityModel[key] {
            let newData = (oldData.value + value).removingDuplicates()
            searchCityModel[key]?.updateValue(newData)
        }
        searchCityModel[key] = model
    }
    
}


protocol SearchCityProtocol {
    var citisOriginal: [CityModel] { get }
    func search(text: String, completion: @escaping (([CityModel]) -> Void))
}

class SearchDefaultImplement: SearchCityProtocol {
    
    var citisOriginal: [CityModel]
    var currentSearchCityModel: [String: SearchCityModel] = SearchService.shared.searchCityModel
    var currentSearchCountryModel: [String: SearchCityModel] = SearchService.shared.searchCountryModel
    init(cities: [CityModel]) {
        self.citisOriginal = cities
    }
    
    func search(text: String, completion: @escaping (([CityModel]) -> Void)) {
        if text.isEmpty {
            completion(citisOriginal)
        } else {
            let group: DispatchGroup = DispatchGroup()
            group.enter()
            var dataFromName: [CityModel] = []
            self.searchFromName(text: text) { data in
                dataFromName = data
                group.leave()
            }
            
            group.enter()
            var dataFromCountry: [CityModel] = []
            self.searchFromCountry(text: text) { data in
                dataFromCountry = data
                group.leave()
            }
            
            group.notify(queue: .main) {
                completion(dataFromName + dataFromCountry)
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
    
    private func searchFromCountry(text: String, completion: (([CityModel]) -> Void)) {
        if  let data = self.currentSearchCountryModel[text.lowercased()] {
            completion(data.value)
        } else {
            completion([])
        }
    }
}
