//
//  ViewController.swift
//  Assignment
//
//  Created by ToanHT on 18/02/2022.
//

import UIKit

struct SearchStringModel {
    var key: String
    var value: [String]
//    var related: [SearchStringModel]
    
    var related: [String: SearchStringModel]
    
//    mutating func updateRelated(related: [SearchStringModel]) {
//        self.related = related
//    }
    
    mutating func updateRelated(related: [String: SearchStringModel]) {
        self.related = related
    }
}

class ViewController: UIViewController {

    private var cities: [CityModel]?
    
    private var searchModel: [String: SearchCityModel] = [:]

    private var searchStringModel: [String: SearchStringModel] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        if let localData = Helper.readLocalFile(forName: "cities") {
            if let model: [CityModel] = Helper.parseArray(jsonData: localData) {
                self.sortData(cities: model)
                self.prepareData()
            } else {
                print("fail =======")
            }
        }
//        let strs: [String] = ["AB", "ABC", "BC"]
//
//        let group = Dictionary.init(grouping: strs) { (item) -> String in
//            return String(item.lowercased().first!)
//        }
//        group.forEach { (key, value) in
//            self.searchStringModel[key] = SearchStringModel(key: key, value: value, related: [:])
//            self.handlerData(key: key, value: value)
//            print("===============")
//        }
//        print("\n============\n \(searchStringModel)")
    }
    
    func prepareData() {
        guard let cities = self.cities else {
            return
        }
        let group = Dictionary.init(grouping: cities) { (item) -> String in
            return String(item.name.lowercased().first!)
        }
        group.forEach { (key, value) in
            self.searchModel[key] = SearchCityModel(key: key, value: value, related: [:])
            self.handlerCitiesData(key: key, cities: value)
        }
        print("===============")
    }
    
    func handlerCitiesData(key: String, cities: [CityModel]) {
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

        guard group.count > 0 else { return }
        self.mapRelatedCityData(key: key, group: group)
        group.forEach { (key, value) in
            if (value.count == 1 && key == value[0].name) || key.isEmpty {
                return
            } else {
                self.handlerCitiesData(key: key, cities: value)
            }
        }
    }
    
    //Todo
    func mapRelatedCityData(key: String, group: [String : [CityModel]]) {
        var data: [String: SearchCityModel] = [:]
        group.forEach { (k, v) in
            let searchModel: SearchCityModel = SearchCityModel(key: k, value: v, related: [:])
            data[k] =  searchModel
        }
        switch key.count {
        case 1:
            self.searchModel[key]?.updateRelated(related: data)
        case 2:
            self.searchModel[key[0]]?.related[key]?.updateRelated(related: data)
        case 3:
            self.searchModel[key[0]]?.related[key[1]]?.related[key]?.updateRelated(related: data)
        case 4:
            self.searchModel[key[0]]?.related[key[1]]?.related[key[2]]?.related[key]?.updateRelated(related: data)
        case 5:
            self.searchModel[key[0]]?.related[key[1]]?.related[key[2]]?.related[key[3]]?.related[key]?.updateRelated(related: data)
        case 6:
            self.searchModel[key[0]]?.related[key[1]]?.related[key[2]]?.related[key[3]]?.related[key[4]]?.related[key]?.updateRelated(related: data)
        case 7:
            self.searchModel[key[0]]?.related[key[1]]?.related[key[2]]?.related[key[3]]?.related[key[4]]?.related[key[5]]?.related[key]?.updateRelated(related: data)
        case 8:
            self.searchModel[key[0]]?.related[key[1]]?.related[key[2]]?.related[key[3]]?.related[key[4]]?.related[key[5]]?.related[key[6]]?.related[key]?.updateRelated(related: data)
        case 9:
            self.searchModel[key[0]]?.related[key[1]]?.related[key[2]]?.related[key[3]]?.related[key[4]]?.related[key[5]]?.related[key[6]]?.related[key[7]]?.related[key]?.updateRelated(related: data)
        case 10:
            self.searchModel[key[0]]?.related[key[1]]?.related[key[2]]?.related[key[3]]?.related[key[4]]?.related[key[5]]?.related[key[6]]?.related[key[7]]?.related[key[8]]?.related[key]?.updateRelated(related: data)
        case 11:
            self.searchModel[key[0]]?.related[key[1]]?.related[key[2]]?.related[key[3]]?.related[key[4]]?.related[key[5]]?.related[key[6]]?.related[key[7]]?.related[key[8]]?.related[key[9]]?.related[key]?.updateRelated(related: data)
        case 12:
            self.searchModel[key[0]]?.related[key[1]]?.related[key[2]]?.related[key[3]]?.related[key[4]]?.related[key[5]]?.related[key[6]]?.related[key[7]]?.related[key[8]]?.related[key[9]]?.related[key[10]]?.related[key]?.updateRelated(related: data)
        case 13:
            self.searchModel[key[0]]?.related[key[1]]?.related[key[2]]?.related[key[3]]?.related[key[4]]?.related[key[5]]?.related[key[6]]?.related[key[7]]?.related[key[8]]?.related[key[9]]?.related[key[10]]?.related[key[11]]?.related[key]?.updateRelated(related: data)
        case 14:
            self.searchModel[key[0]]?.related[key[1]]?.related[key[2]]?.related[key[3]]?.related[key[4]]?.related[key[5]]?.related[key[6]]?.related[key[7]]?.related[key[8]]?.related[key[9]]?.related[key[10]]?.related[key[11]]?.related[key[12]]?.related[key]?.updateRelated(related: data)
        case 15:
            self.searchModel[key[0]]?.related[key[1]]?.related[key[2]]?.related[key[3]]?.related[key[4]]?.related[key[5]]?.related[key[6]]?.related[key[7]]?.related[key[8]]?.related[key[9]]?.related[key[10]]?.related[key[11]]?.related[key[12]]?.related[key[13]]?.related[key]?.updateRelated(related: data)
        case 16:
            self.searchModel[key[0]]?.related[key[1]]?.related[key[2]]?.related[key[3]]?.related[key[4]]?.related[key[5]]?.related[key[6]]?.related[key[7]]?.related[key[8]]?.related[key[9]]?.related[key[10]]?.related[key[11]]?.related[key[12]]?.related[key[13]]?.related[key[14]]?.related[key]?.updateRelated(related: data)
        case 17:
            self.searchModel[key[0]]?.related[key[1]]?.related[key[2]]?.related[key[3]]?.related[key[4]]?.related[key[5]]?.related[key[6]]?.related[key[7]]?.related[key[8]]?.related[key[9]]?.related[key[10]]?.related[key[11]]?.related[key[12]]?.related[key[13]]?.related[key[14]]?.related[key[15]]?.related[key]?.updateRelated(related: data)
        case 18:
            self.searchModel[key[0]]?.related[key[1]]?.related[key[2]]?.related[key[3]]?.related[key[4]]?.related[key[5]]?.related[key[6]]?.related[key[7]]?.related[key[8]]?.related[key[9]]?.related[key[10]]?.related[key[11]]?.related[key[12]]?.related[key[13]]?.related[key[14]]?.related[key[15]]?.related[key[16]]?.related[key]?.updateRelated(related: data)
        case 19:
            self.searchModel[key[0]]?.related[key[1]]?.related[key[2]]?.related[key[3]]?.related[key[4]]?.related[key[5]]?.related[key[6]]?.related[key[7]]?.related[key[8]]?.related[key[9]]?.related[key[10]]?.related[key[11]]?.related[key[12]]?.related[key[13]]?.related[key[14]]?.related[key[15]]?.related[key[16]]?.related[key[17]]?.related[key]?.updateRelated(related: data)
        case 20:
            self.searchModel[key[0]]?.related[key[1]]?.related[key[2]]?.related[key[3]]?.related[key[4]]?.related[key[5]]?.related[key[6]]?.related[key[7]]?.related[key[8]]?.related[key[9]]?.related[key[10]]?.related[key[11]]?.related[key[12]]?.related[key[13]]?.related[key[14]]?.related[key[15]]?.related[key[16]]?.related[key[17]]?.related[key[18]]?.related[key]?.updateRelated(related: data)
        case 21:
            self.searchModel[key[0]]?.related[key[1]]?.related[key[2]]?.related[key[3]]?.related[key[4]]?.related[key[5]]?.related[key[6]]?.related[key[7]]?.related[key[8]]?.related[key[9]]?.related[key[10]]?.related[key[11]]?.related[key[12]]?.related[key[13]]?.related[key[14]]?.related[key[15]]?.related[key[16]]?.related[key[17]]?.related[key[18]]?.related[key[19]]?.related[key]?.updateRelated(related: data)
        case 22:
            self.searchModel[key[0]]?.related[key[1]]?.related[key[2]]?.related[key[3]]?.related[key[4]]?.related[key[5]]?.related[key[6]]?.related[key[7]]?.related[key[8]]?.related[key[9]]?.related[key[10]]?.related[key[11]]?.related[key[12]]?.related[key[13]]?.related[key[14]]?.related[key[15]]?.related[key[16]]?.related[key[17]]?.related[key[18]]?.related[key[19]]?.related[key[20]]?.related[key]?.updateRelated(related: data)
        case 23:
            self.searchModel[key[0]]?.related[key[1]]?.related[key[2]]?.related[key[3]]?.related[key[4]]?.related[key[5]]?.related[key[6]]?.related[key[7]]?.related[key[8]]?.related[key[9]]?.related[key[10]]?.related[key[11]]?.related[key[12]]?.related[key[13]]?.related[key[14]]?.related[key[15]]?.related[key[16]]?.related[key[17]]?.related[key[18]]?.related[key[19]]?.related[key[20]]?.related[key[21]]?.related[key]?.updateRelated(related: data)
        case 24:
            self.searchModel[key[0]]?.related[key[1]]?.related[key[2]]?.related[key[3]]?.related[key[4]]?.related[key[5]]?.related[key[6]]?.related[key[7]]?.related[key[8]]?.related[key[9]]?.related[key[10]]?.related[key[11]]?.related[key[12]]?.related[key[13]]?.related[key[14]]?.related[key[15]]?.related[key[16]]?.related[key[17]]?.related[key[18]]?.related[key[19]]?.related[key[20]]?.related[key[21]]?.related[key[22]]?.related[key]?.updateRelated(related: data)
        case 25:
            self.searchModel[key[0]]?.related[key[1]]?.related[key[2]]?.related[key[3]]?.related[key[4]]?.related[key[5]]?.related[key[6]]?.related[key[7]]?.related[key[8]]?.related[key[9]]?.related[key[10]]?.related[key[11]]?.related[key[12]]?.related[key[13]]?.related[key[14]]?.related[key[15]]?.related[key[16]]?.related[key[17]]?.related[key[18]]?.related[key[19]]?.related[key[20]]?.related[key[21]]?.related[key[22]]?.related[key[23]]?.related[key]?.updateRelated(related: data)
        case 26:
            self.searchModel[key[0]]?.related[key[1]]?.related[key[2]]?.related[key[3]]?.related[key[4]]?.related[key[5]]?.related[key[6]]?.related[key[7]]?.related[key[8]]?.related[key[9]]?.related[key[10]]?.related[key[11]]?.related[key[12]]?.related[key[13]]?.related[key[14]]?.related[key[15]]?.related[key[16]]?.related[key[17]]?.related[key[18]]?.related[key[19]]?.related[key[20]]?.related[key[21]]?.related[key[22]]?.related[key[23]]?.related[key[24]]?.related[key]?.updateRelated(related: data)
        case 27:
            self.searchModel[key[0]]?.related[key[1]]?.related[key[2]]?.related[key[3]]?.related[key[4]]?.related[key[5]]?.related[key[6]]?.related[key[7]]?.related[key[8]]?.related[key[9]]?.related[key[10]]?.related[key[11]]?.related[key[12]]?.related[key[13]]?.related[key[14]]?.related[key[15]]?.related[key[16]]?.related[key[17]]?.related[key[18]]?.related[key[19]]?.related[key[20]]?.related[key[21]]?.related[key[22]]?.related[key[23]]?.related[key[24]]?.related[key[25]]?.related[key]?.updateRelated(related: data)
        case 28:
            self.searchModel[key[0]]?.related[key[1]]?.related[key[2]]?.related[key[3]]?.related[key[4]]?.related[key[5]]?.related[key[6]]?.related[key[7]]?.related[key[8]]?.related[key[9]]?.related[key[10]]?.related[key[11]]?.related[key[12]]?.related[key[13]]?.related[key[14]]?.related[key[15]]?.related[key[16]]?.related[key[17]]?.related[key[18]]?.related[key[19]]?.related[key[20]]?.related[key[21]]?.related[key[22]]?.related[key[23]]?.related[key[24]]?.related[key[25]]?.related[key[26]]?.related[key]?.updateRelated(related: data)
        case 29:
            self.searchModel[key[0]]?.related[key[1]]?.related[key[2]]?.related[key[3]]?.related[key[4]]?.related[key[5]]?.related[key[6]]?.related[key[7]]?.related[key[8]]?.related[key[9]]?.related[key[10]]?.related[key[11]]?.related[key[12]]?.related[key[13]]?.related[key[14]]?.related[key[15]]?.related[key[16]]?.related[key[17]]?.related[key[18]]?.related[key[19]]?.related[key[20]]?.related[key[21]]?.related[key[22]]?.related[key[23]]?.related[key[24]]?.related[key[25]]?.related[key[26]]?.related[key[27]]?.related[key]?.updateRelated(related: data)
        case 30:
            self.searchModel[key[0]]?.related[key[1]]?.related[key[2]]?.related[key[3]]?.related[key[4]]?.related[key[5]]?.related[key[6]]?.related[key[7]]?.related[key[8]]?.related[key[9]]?.related[key[10]]?.related[key[11]]?.related[key[12]]?.related[key[13]]?.related[key[14]]?.related[key[15]]?.related[key[16]]?.related[key[17]]?.related[key[18]]?.related[key[19]]?.related[key[20]]?.related[key[21]]?.related[key[22]]?.related[key[23]]?.related[key[24]]?.related[key[25]]?.related[key[26]]?.related[key[27]]?.related[key[28]]?.related[key]?.updateRelated(related: data)
        default:
            break
            
        }
    }
    
    private func sortData(cities: [CityModel]) {
        let citiesSort = cities.sorted { $0.name.lowercased() < $1.name.lowercased() }
        self.cities = citiesSort

    }


    
    @IBAction func testButtonTapped() {
//        print("\(self.searchModel)")
        
        guard let cities = cities else { return }
        let searchService: SearchCityProtocol = SearchDefaultImplement(cities: cities, currentSearch: self.searchModel)
        let vc = CitiesViewController(searchService: searchService)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

//extension ViewController {
//func handlerData(key: String, value: [String]) {
//    var string: String = ""
//    let group = Dictionary.init(grouping: value) { (item) -> String in
//        if key.count < item.count {
//            string = (key + item[key.count]).lowercased()
//            return string
//        } else {
//            return ""
//        }
//    }.filter {
//        $0.key != ""
//    }
//
//    guard group.count > 0 else { return }
//    self.mapRelatedData(key: key, group: group)
//    group.forEach { (key, value) in
//        if (value.count == 1 && key == value[0]) || key.isEmpty {
//            return
//        } else {
//            self.handlerData(key: key, value: value)
//        }
//    }
//}

//    func setupDataWithName(cities: [CityModel]) {
//        let groupName = Dictionary(grouping: cities) { (city) -> String in
//            return String(city.name.lowercased()[0])
//        }
//
//        let seachModel: [SearchCityModel] = groupName.compactMap { (key, value) in
//            return SearchCityModel(key: key, value: value, related: [])
//        }
//
//    }
//
//    func handerRelatedData(key: String, cities: [CityModel]) {
//        let group = Dictionary.init(grouping: cities) { (city) -> String in
//            if key.count < city.name.count {
//                let string = (key + city.name[key.count]).lowercased()
//                return string
//            } else {
//                return ""
//            }
//        }.filter {
//            $0.key != ""
//        }
//
////        self.searchModel[key] = SearchCityModel(cities: cities, searchDataDic: <#T##[String : [CityModel]]#>)
//        guard group.count > 0 else { return }
//        group.forEach { (key, value) in
//            if (value.count == 1 && key == value[0].name) || key.isEmpty {
//                return
//            } else {
//                self.handlerSearchData(key: key, cities: value)
//            }
//        }
//    }
//
//
//}


//extension ViewController {
//
//    func parseRelated(key: String, value: [String]) -> [String: SearchStringModel] {
//        var data: [String: SearchStringModel] = [:]
//        data[key] = SearchStringModel(key: key, value: value, related: [:])
//        return data
//    }
//    func handlerRelated(key: String, cities: [CityModel]) -> [SearchCityModel] {
//
//
//
//        return []
//    }
//
//
//    func handlerSearchGroup(key: String, cities: [CityModel]) -> SearchCityModel {
//        let group = Dictionary(grouping: cities) { _ in
//            return key
//        }
//        let searchModel = SearchCityModel(key: key, value: cities, related: [])
//        return searchModel
//    }
//
//    func handlerCustomData(cities: [CityModel]) -> [String : [CityModel]] {
//
//        let groupName = Dictionary(grouping: cities) { (city) -> String in
//            return String(city.name.lowercased().first!)
//        }
//        return groupName
//    }
//
//    func prepareSearchDataModel(cities: [CityModel]) -> [String:SearchCityModel] {
//
//        let groupName = Dictionary(grouping: cities) { (city) -> String in
//            return String(city.name.lowercased().first!)
//        }
//
////        return groupName
//        return [:]
//    }
//
//    func handlerSearchData(key: String, cities: [CityModel]) {
//        let group = Dictionary.init(grouping: cities) { (city) -> String in
//            if key.count < city.name.count {
//                let string = (key + city.name[key.count]).lowercased()
//                return string
//            } else {
//                return ""
//            }
//        }.filter {
//            $0.key != ""
//        }
//
////        self.searchModel[key] = SearchCityModel(cities: cities, searchDataDic: <#T##[String : [CityModel]]#>)
//        guard group.count > 0 else { return }
//        group.forEach { (key, value) in
//            if (value.count == 1 && key == value[0].name) || key.isEmpty {
//                return
//            } else {
//                self.handlerSearchData(key: key, cities: value)
//            }
//        }
//    }
//
//    func mapRelatedData(key: String, group: [String : [String]]) {
//        var data: [String: SearchStringModel] = [:]
//        group.forEach { (k, v) in
//            let searchModel: SearchStringModel = SearchStringModel(key: k, value: v, related: [:])
//            data[k] =  searchModel
//        }
//        switch key.count {
//        case 1:
//            self.searchStringModel[key]?.updateRelated(related: data)
//        case 2:
//            self.searchStringModel[key[0]]?.related[key]?.updateRelated(related: data)
//        case 3:
//            self.searchStringModel[key[0]]?.related[key[1]]?.related[key]?.updateRelated(related: data)
//        case 4:
//            self.searchStringModel[key[0]]?.related[key[1]]?.related[key[2]]?.related[key]?.updateRelated(related: data)
//        case 5:
//            self.searchStringModel[key[0]]?.related[key[1]]?.related[key[2]]?.related[key[3]]?.related[key]?.updateRelated(related: data)
//        case 6:
//            self.searchStringModel[key[0]]?.related[key[1]]?.related[key[2]]?.related[key[3]]?.related[key[4]]?.related[key]?.updateRelated(related: data)
//        case 7:
//            self.searchStringModel[key[0]]?.related[key[1]]?.related[key[2]]?.related[key[3]]?.related[key[4]]?.related[key[5]]?.related[key]?.updateRelated(related: data)
//        case 8:
//            self.searchStringModel[key[0]]?.related[key[1]]?.related[key[2]]?.related[key[3]]?.related[key[4]]?.related[key[5]]?.related[key[6]]?.related[key]?.updateRelated(related: data)
//        case 9:
//            self.searchStringModel[key[0]]?.related[key[1]]?.related[key[2]]?.related[key[3]]?.related[key[4]]?.related[key[5]]?.related[key[6]]?.related[key[7]]?.related[key]?.updateRelated(related: data)
//        case 10:
//            self.searchStringModel[key[0]]?.related[key[1]]?.related[key[2]]?.related[key[3]]?.related[key[4]]?.related[key[5]]?.related[key[6]]?.related[key[7]]?.related[key[8]]?.related[key]?.updateRelated(related: data)
//        case 11:
//            self.searchStringModel[key[0]]?.related[key[1]]?.related[key[2]]?.related[key[3]]?.related[key[4]]?.related[key[5]]?.related[key[6]]?.related[key[7]]?.related[key[8]]?.related[key[9]]?.related[key]?.updateRelated(related: data)
//        case 12:
//            self.searchStringModel[key[0]]?.related[key[1]]?.related[key[2]]?.related[key[3]]?.related[key[4]]?.related[key[5]]?.related[key[6]]?.related[key[7]]?.related[key[8]]?.related[key[9]]?.related[key[10]]?.related[key]?.updateRelated(related: data)
//        case 13:
//            self.searchStringModel[key[0]]?.related[key[1]]?.related[key[2]]?.related[key[3]]?.related[key[4]]?.related[key[5]]?.related[key[6]]?.related[key[7]]?.related[key[8]]?.related[key[9]]?.related[key[10]]?.related[key[11]]?.related[key]?.updateRelated(related: data)
//        case 14:
//            self.searchStringModel[key[0]]?.related[key[1]]?.related[key[2]]?.related[key[3]]?.related[key[4]]?.related[key[5]]?.related[key[6]]?.related[key[7]]?.related[key[8]]?.related[key[9]]?.related[key[10]]?.related[key[11]]?.related[key[12]]?.related[key]?.updateRelated(related: data)
//        case 15:
//            self.searchStringModel[key[0]]?.related[key[1]]?.related[key[2]]?.related[key[3]]?.related[key[4]]?.related[key[5]]?.related[key[6]]?.related[key[7]]?.related[key[8]]?.related[key[9]]?.related[key[10]]?.related[key[11]]?.related[key[12]]?.related[key[13]]?.related[key]?.updateRelated(related: data)
//        case 16:
//            self.searchStringModel[key[0]]?.related[key[1]]?.related[key[2]]?.related[key[3]]?.related[key[4]]?.related[key[5]]?.related[key[6]]?.related[key[7]]?.related[key[8]]?.related[key[9]]?.related[key[10]]?.related[key[11]]?.related[key[12]]?.related[key[13]]?.related[key[14]]?.related[key]?.updateRelated(related: data)
//        case 17:
//            self.searchStringModel[key[0]]?.related[key[1]]?.related[key[2]]?.related[key[3]]?.related[key[4]]?.related[key[5]]?.related[key[6]]?.related[key[7]]?.related[key[8]]?.related[key[9]]?.related[key[10]]?.related[key[11]]?.related[key[12]]?.related[key[13]]?.related[key[14]]?.related[key[15]]?.related[key]?.updateRelated(related: data)
//        case 18:
//            self.searchStringModel[key[0]]?.related[key[1]]?.related[key[2]]?.related[key[3]]?.related[key[4]]?.related[key[5]]?.related[key[6]]?.related[key[7]]?.related[key[8]]?.related[key[9]]?.related[key[10]]?.related[key[11]]?.related[key[12]]?.related[key[13]]?.related[key[14]]?.related[key[15]]?.related[key[16]]?.related[key]?.updateRelated(related: data)
//        case 19:
//            self.searchStringModel[key[0]]?.related[key[1]]?.related[key[2]]?.related[key[3]]?.related[key[4]]?.related[key[5]]?.related[key[6]]?.related[key[7]]?.related[key[8]]?.related[key[9]]?.related[key[10]]?.related[key[11]]?.related[key[12]]?.related[key[13]]?.related[key[14]]?.related[key[15]]?.related[key[16]]?.related[key[17]]?.related[key]?.updateRelated(related: data)
//        case 20:
//            self.searchStringModel[key[0]]?.related[key[1]]?.related[key[2]]?.related[key[3]]?.related[key[4]]?.related[key[5]]?.related[key[6]]?.related[key[7]]?.related[key[8]]?.related[key[9]]?.related[key[10]]?.related[key[11]]?.related[key[12]]?.related[key[13]]?.related[key[14]]?.related[key[15]]?.related[key[16]]?.related[key[17]]?.related[key[18]]?.related[key]?.updateRelated(related: data)
//        case 21:
//            self.searchStringModel[key[0]]?.related[key[1]]?.related[key[2]]?.related[key[3]]?.related[key[4]]?.related[key[5]]?.related[key[6]]?.related[key[7]]?.related[key[8]]?.related[key[9]]?.related[key[10]]?.related[key[11]]?.related[key[12]]?.related[key[13]]?.related[key[14]]?.related[key[15]]?.related[key[16]]?.related[key[17]]?.related[key[18]]?.related[key[19]]?.related[key]?.updateRelated(related: data)
//        case 22:
//            self.searchStringModel[key[0]]?.related[key[1]]?.related[key[2]]?.related[key[3]]?.related[key[4]]?.related[key[5]]?.related[key[6]]?.related[key[7]]?.related[key[8]]?.related[key[9]]?.related[key[10]]?.related[key[11]]?.related[key[12]]?.related[key[13]]?.related[key[14]]?.related[key[15]]?.related[key[16]]?.related[key[17]]?.related[key[18]]?.related[key[19]]?.related[key[20]]?.related[key]?.updateRelated(related: data)
//        case 23:
//            self.searchStringModel[key[0]]?.related[key[1]]?.related[key[2]]?.related[key[3]]?.related[key[4]]?.related[key[5]]?.related[key[6]]?.related[key[7]]?.related[key[8]]?.related[key[9]]?.related[key[10]]?.related[key[11]]?.related[key[12]]?.related[key[13]]?.related[key[14]]?.related[key[15]]?.related[key[16]]?.related[key[17]]?.related[key[18]]?.related[key[19]]?.related[key[20]]?.related[key[21]]?.related[key]?.updateRelated(related: data)
//        case 24:
//            self.searchStringModel[key[0]]?.related[key[1]]?.related[key[2]]?.related[key[3]]?.related[key[4]]?.related[key[5]]?.related[key[6]]?.related[key[7]]?.related[key[8]]?.related[key[9]]?.related[key[10]]?.related[key[11]]?.related[key[12]]?.related[key[13]]?.related[key[14]]?.related[key[15]]?.related[key[16]]?.related[key[17]]?.related[key[18]]?.related[key[19]]?.related[key[20]]?.related[key[21]]?.related[key[22]]?.related[key]?.updateRelated(related: data)
//        case 25:
//            self.searchStringModel[key[0]]?.related[key[1]]?.related[key[2]]?.related[key[3]]?.related[key[4]]?.related[key[5]]?.related[key[6]]?.related[key[7]]?.related[key[8]]?.related[key[9]]?.related[key[10]]?.related[key[11]]?.related[key[12]]?.related[key[13]]?.related[key[14]]?.related[key[15]]?.related[key[16]]?.related[key[17]]?.related[key[18]]?.related[key[19]]?.related[key[20]]?.related[key[21]]?.related[key[22]]?.related[key[23]]?.related[key]?.updateRelated(related: data)
//        case 26:
//            self.searchStringModel[key[0]]?.related[key[1]]?.related[key[2]]?.related[key[3]]?.related[key[4]]?.related[key[5]]?.related[key[6]]?.related[key[7]]?.related[key[8]]?.related[key[9]]?.related[key[10]]?.related[key[11]]?.related[key[12]]?.related[key[13]]?.related[key[14]]?.related[key[15]]?.related[key[16]]?.related[key[17]]?.related[key[18]]?.related[key[19]]?.related[key[20]]?.related[key[21]]?.related[key[22]]?.related[key[23]]?.related[key[24]]?.related[key]?.updateRelated(related: data)
//        case 27:
//            self.searchStringModel[key[0]]?.related[key[1]]?.related[key[2]]?.related[key[3]]?.related[key[4]]?.related[key[5]]?.related[key[6]]?.related[key[7]]?.related[key[8]]?.related[key[9]]?.related[key[10]]?.related[key[11]]?.related[key[12]]?.related[key[13]]?.related[key[14]]?.related[key[15]]?.related[key[16]]?.related[key[17]]?.related[key[18]]?.related[key[19]]?.related[key[20]]?.related[key[21]]?.related[key[22]]?.related[key[23]]?.related[key[24]]?.related[key[25]]?.related[key]?.updateRelated(related: data)
//        case 28:
//            self.searchStringModel[key[0]]?.related[key[1]]?.related[key[2]]?.related[key[3]]?.related[key[4]]?.related[key[5]]?.related[key[6]]?.related[key[7]]?.related[key[8]]?.related[key[9]]?.related[key[10]]?.related[key[11]]?.related[key[12]]?.related[key[13]]?.related[key[14]]?.related[key[15]]?.related[key[16]]?.related[key[17]]?.related[key[18]]?.related[key[19]]?.related[key[20]]?.related[key[21]]?.related[key[22]]?.related[key[23]]?.related[key[24]]?.related[key[25]]?.related[key[26]]?.related[key]?.updateRelated(related: data)
//        case 29:
//            self.searchStringModel[key[0]]?.related[key[1]]?.related[key[2]]?.related[key[3]]?.related[key[4]]?.related[key[5]]?.related[key[6]]?.related[key[7]]?.related[key[8]]?.related[key[9]]?.related[key[10]]?.related[key[11]]?.related[key[12]]?.related[key[13]]?.related[key[14]]?.related[key[15]]?.related[key[16]]?.related[key[17]]?.related[key[18]]?.related[key[19]]?.related[key[20]]?.related[key[21]]?.related[key[22]]?.related[key[23]]?.related[key[24]]?.related[key[25]]?.related[key[26]]?.related[key[27]]?.related[key]?.updateRelated(related: data)
//        case 30:
//            self.searchStringModel[key[0]]?.related[key[1]]?.related[key[2]]?.related[key[3]]?.related[key[4]]?.related[key[5]]?.related[key[6]]?.related[key[7]]?.related[key[8]]?.related[key[9]]?.related[key[10]]?.related[key[11]]?.related[key[12]]?.related[key[13]]?.related[key[14]]?.related[key[15]]?.related[key[16]]?.related[key[17]]?.related[key[18]]?.related[key[19]]?.related[key[20]]?.related[key[21]]?.related[key[22]]?.related[key[23]]?.related[key[24]]?.related[key[25]]?.related[key[26]]?.related[key[27]]?.related[key[28]]?.related[key]?.updateRelated(related: data)
//        default:
//            break
//
//        }
//    }
//}
