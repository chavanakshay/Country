//
//  CreateCountryListViewTests.swift
//  CountryTests
//
//  Created by a.diliprao.chavan on 10/05/22.
//

import XCTest
@testable import Country

class CreateCountryListViewTests: XCTestCase {
    
    var sut: CreateCountryListView!
    var interactorSpy: CreateCountryListInteractorSpy!

    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = CreateCountryListView()
        interactorSpy = CreateCountryListInteractorSpy()
    }
    
    // MARK: - Test doubles
    class CreateCountryListInteractorSpy: CreateCountryListBusinessLogic {
        var loadCountryCalled = false
        func loadCountries(request: CreateCountryList.LoadCountryList.Request, useCase: CountryListUseCaseProtocol) {
            loadCountryCalled = true
        }
    }
    
    // MARK: - Tests
    func testShouldLoadCountryListOnViewAppear() {
      // Given
      sut.interactor = interactorSpy
      // When
      sut.fetchCountryList()
      // Then
      XCTAssertTrue(
        interactorSpy.loadCountryCalled,
        "fetchCountryList() should ask the interactor to load the country"
      )
    }

    override func tearDownWithError() throws {
        sut = nil
        interactorSpy = nil
        try super.tearDownWithError()
    }
}
