//
//  CreateCountryListPresenterTests.swift
//  CountryTests
//
//  Created by a.diliprao.chavan on 10/05/22.
//

import XCTest
@testable import Country

class CreateCountryListPresenterTests: XCTestCase {
    var sut: CreateCountryListPresenter!
    var viewSpy: CreateCountryListViewSpy!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = CreateCountryListPresenter()
        viewSpy = CreateCountryListViewSpy()
    }
    
    class CreateCountryListViewSpy:CreateCountryListDisplayProtocol{
        var isCountryListDisplayed = false
        var dataStore:CountryDataStore = CountryDataStore()
        func displayCountryList(response: CreateCountryList.LoadCountryList.ViewModel) {
            isCountryListDisplayed = true
            dataStore.countryList = response.countryList
        }
        
        func displayError(message: String) {
            dataStore.errorMessage = message
        }
    }
    
    // MARK: - Tests
    func testIsCountryListDisplayed(){
      //Given
      sut.view = viewSpy
        let country = Seeds.country
      
      //When
      sut.presentCountryList(response: CreateCountryList.LoadCountryList.Response(countryList: [country]))
      
      //Then
      XCTAssertTrue(viewSpy.isCountryListDisplayed)
      
    }
    
    func testPresentedCountryByPresenter(){
      //Given
      sut.view = viewSpy
        let country = Seeds.country
      
      //When
      sut.presentCountryList(response: CreateCountryList.LoadCountryList.Response(countryList: [country]))
      
      //Then
        XCTAssertEqual(viewSpy.dataStore.countryList.count, 1)
        XCTAssertEqual(viewSpy.dataStore.countryList.first?.id, country.iD)
        XCTAssertEqual(viewSpy.dataStore.countryList.first?.name, country.name)
        XCTAssertEqual(viewSpy.dataStore.countryList.first?.formattedPhoneCode, "Phone code: \(country.phoneCode!)")
        XCTAssertEqual(viewSpy.dataStore.countryList.first?.formattedCode, "Code: \(country.code!)")
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
