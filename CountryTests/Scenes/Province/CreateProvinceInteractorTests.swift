//
//  CreateProvinceInteractorTests.swift
//  CountryTests
//
//  Created by a.diliprao.chavan on 10/05/22.
//

import XCTest
@testable import Country

class CreateProvinceInteractorTests: XCTestCase {
    var sut: CreateProvinceListInteractor!
    var presenterSpy: CreateProvinceListPresenterSpy!
    
    override func setUpWithError() throws {
        sut = CreateProvinceListInteractor()
        presenterSpy = CreateProvinceListPresenterSpy()
    }
    
    // MARK: - Test doubles
    class CreateProvinceListPresenterSpy: CreateProvinceListPresentationLogic {
        var presentCountryCalled = false
        var errorMessageCalled = false
        var province: [Province] = []
        
        func presentProvinceList(response: CreateProvinceList.LoadProvinceList.Response) {
            presentCountryCalled = true
            province = response.provinceList
        }
        
        func showErrorMessage(message: String) {
            errorMessageCalled = true
        }
    }
    
    // MARK: - Tests
    func testLoadCountryListCallsPresenterToPresentCountryList() {
      // Given
        sut.presenter = presenterSpy
      // When
        let request = CreateProvinceList.LoadProvinceList.Request.province(id: "123")
        sut.loadProvince(request: request)
      // Then
        XCTAssertEqual(presenterSpy.errorMessageCalled, false)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

}
