//
//  AssignmentTests.swift
//  AssignmentTests
//
//  Created by ToanHT on 18/02/2022.
//

import XCTest
@testable import Assignment

class AssignmentTests: XCTestCase {

    let cityTest: CityModel = CityModel(country: "US", name: "Alabama", _id: 4829764, coord: CoordinateModel(lon: -86.750259, lat: 32.750408))
    let cityTestSpace: CityModel = CityModel(country: "US", name: "Falls County", _id: 4690103, coord: CoordinateModel(lon: -96.933601, lat: 31.26684))
    let cityTestSpecialSymbol: CityModel = CityModel(country: "FI", name: "Öja", _id: 643991, coord: CoordinateModel(lon: 22.91667, lat: 63.833328))
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
        
        SuffixReferenceService.shared.loadData { status in
//            let searchService: SearchCityProtocol = SearchDefaultImplement(cities: SearchService.shared.cities)
            let searchService: SearchCityProtocol = SearchSufixImplement(cities: SuffixReferenceService.shared.cities)
            self.testCityName(searchText: "Ala", searchService: searchService)
            self.testCityNameParticular(searchText: "Alabama", searchService: searchService)
            self.testNameCityFail(searchText: "Alabamaaaa", searchService: searchService)
            self.testCounttry(searchText: "US", searchService: searchService)
            self.testCounttryFail(searchText: "USsss", searchService: searchService)
            
            self.testCityNameSpace(searchText: "Falls C", searchService: searchService)
            self.testCityNameParticularSpace(searchText: "Falls County", searchService: searchService)
            self.testNameCityFailSpace(searchText: "FallsCounty", searchService: searchService)
            
            self.testCityNameSpecialSymbol(searchText: "Öj", searchService: searchService)
            self.testCityNameParticularSpecialSymbol(searchText: "Öja", searchService: searchService)
            self.testNameCityFailSpecialSymbol(searchText: "Öja ", searchService: searchService)
            
        }
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testCityName(searchText: String, searchService: SearchCityProtocol) {
        searchService.search(text: searchText) { cities in
            XCTAssert(cities.count > 1)
        }
    }

    func testCityNameParticular(searchText: String, searchService: SearchCityProtocol) {
        searchService.search(text: searchText) { cities in
            XCTAssert(cities.count == 1)
            XCTAssertEqual(self.cityTest.name, cities.first?.name)
            XCTAssertEqual(self.cityTest._id, cities.first?._id)
        }
    }
    
    func testNameCityFail(searchText: String, searchService: SearchCityProtocol) {
        searchService.search(text: searchText) { cities in
            XCTAssert(cities.count > 0)
        }
    }
    
    func testCounttry(searchText: String, searchService: SearchCityProtocol) {
        searchService.search(text: searchText) { cities in
            XCTAssert(cities.count > 0)
        }
    }
    
    func testCounttryFail(searchText: String, searchService: SearchCityProtocol) {
        searchService.search(text: searchText) { cities in
            XCTAssert(cities.count > 0)
        }
    }
    
    func testCityNameSpace(searchText: String, searchService: SearchCityProtocol) {
        searchService.search(text: searchText) { cities in
            XCTAssert(cities.count > 1)
        }
    }
    
    func testCityNameParticularSpace(searchText: String, searchService: SearchCityProtocol) {
        searchService.search(text: searchText) { cities in
            XCTAssert(cities.count == 1)
            XCTAssertEqual(self.cityTestSpace.name, cities.first?.name)
            XCTAssertEqual(self.cityTestSpace._id, cities.first?._id)
        }
    }
    
    func testNameCityFailSpace(searchText: String, searchService: SearchCityProtocol) {
        searchService.search(text: searchText) { cities in
            XCTAssert(cities.count > 0)
        }
    }
    
    func testCityNameSpecialSymbol(searchText: String, searchService: SearchCityProtocol) {
        searchService.search(text: searchText) { cities in
            XCTAssert(cities.count > 1)
        }
    }
    
    func testCityNameParticularSpecialSymbol(searchText: String, searchService: SearchCityProtocol) {
        searchService.search(text: searchText) { cities in
            XCTAssert(cities.count == 1)
            XCTAssertEqual(self.cityTestSpecialSymbol.name, cities.first?.name)
            XCTAssertEqual(self.cityTestSpecialSymbol._id, cities.first?._id)
        }
    }
    
    func testNameCityFailSpecialSymbol(searchText: String, searchService: SearchCityProtocol) {
        searchService.search(text: searchText) { cities in
            XCTAssert(cities.count > 0)
        }
    }

}
