//
//  CreateProvinceListViewTests.swift
//  CountryTests
//
//  Created by a.diliprao.chavan on 10/05/22.
//

import XCTest
@testable import Country

class CreateProvinceListViewTests: XCTestCase {
    var sut: CreateProvinceListView!
    var interactorSpy: CreateProvinceListInteractorSpy!

    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = CreateProvinceListView(countryId: "123")
        interactorSpy = CreateProvinceListInteractorSpy()
    }
    
    // MARK: - Test doubles
    class CreateProvinceListInteractorSpy: CreateProvinceListBusinessLogic {
        var loadProvinceCalled = false
        func loadProvince(request: CreateProvinceList.LoadProvinceList.Request) {
            loadProvinceCalled = true
        }
    }
    
    // MARK: - Tests
    func testShouldLoadProvinceListOnViewAppear() {
      // Given
      sut.interactor = interactorSpy
      // When
        sut.fetchProvinceList(id: sut.countryId)
      // Then
      XCTAssertTrue(
        interactorSpy.loadProvinceCalled,
        "fetchProvinceList should ask the interactor to load the province"
      )
    }
    
    func testConfigurator(){
        // Given
        sut.interactor = interactorSpy
        // When
        sut.configureView()
        // Then
        XCTAssertNotNil(sut.interactor)
    }

    
    func testCountryId(){
        XCTAssertEqual(sut.countryId, "123")
    }

    override func tearDownWithError() throws {
        sut = nil
        interactorSpy = nil
        try super.tearDownWithError()
    }

}
