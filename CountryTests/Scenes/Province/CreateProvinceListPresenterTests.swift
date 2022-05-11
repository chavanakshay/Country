//
//  CreateProvinceListPresenterTests.swift
//  CountryTests
//
//  Created by a.diliprao.chavan on 10/05/22.
//

import XCTest
@testable import Country

class CreateProvinceListPresenterTests: XCTestCase {
    var sut: CreateProvinceListPresenter!
    var viewSpy: CreateProvinceListViewSpy!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = CreateProvinceListPresenter()
        viewSpy = CreateProvinceListViewSpy()
    }
    
    class CreateProvinceListViewSpy:CreateProvinceListDisplayProtocol{

        var isProvinceListDisplayed = false
        var dataStore:ProvinceDataStore = ProvinceDataStore()
        func displayProvinceList(response: CreateProvinceList.LoadProvinceList.ViewModel) {
            isProvinceListDisplayed = true
            dataStore.provinceList = response.provinceList
        }
        
        func displayError(message: String) {
            dataStore.errorMessage = message
        }
    }
    
    
    
    // MARK: - Tests
    func testIsProvinceListDisplayed(){
      //Given
      sut.view = viewSpy
        let province = Seeds.province
      
      //When
      sut.presentProvinceList(response: CreateProvinceList.LoadProvinceList.Response(provinceList: [province]))
      
      //Then
      XCTAssertTrue(viewSpy.isProvinceListDisplayed)
      
    }
    
    func testPresentedProvinceByPresenter(){
      //Given
      sut.view = viewSpy
        let province = Seeds.province
      
      //When
      sut.presentProvinceList(response: CreateProvinceList.LoadProvinceList.Response(provinceList: [province]))
      
      //Then
        XCTAssertEqual(viewSpy.dataStore.provinceList.count, 1)
        XCTAssertEqual(viewSpy.dataStore.provinceList.first?.id, province.iD)
        XCTAssertEqual(viewSpy.dataStore.provinceList.first?.name, province.name)
        XCTAssertEqual(viewSpy.dataStore.provinceList.first?.formattedCountryCode, "Country code: \(province.countryCode!)")
        XCTAssertEqual(viewSpy.dataStore.provinceList.first?.formattedCode, "Code: \(province.code!)")
    }
    
    func testdisplayError(){
      //Given
      sut.view = viewSpy
        let error = "Error Message"
      
      //When
      sut.view?.displayError(message: error)
      
      //Then
        XCTAssertEqual(viewSpy.dataStore.errorMessage, error)
      
    }

    override func tearDownWithError() throws {
        sut = nil
        viewSpy = nil
        try super.tearDownWithError()
    }
}
