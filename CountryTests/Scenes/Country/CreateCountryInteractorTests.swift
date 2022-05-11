//
//  CreateCountryInteractorTests.swift
//  CountryTests
//
//  Created by a.diliprao.chavan on 10/05/22.
//

import XCTest
@testable import Country
import Combine

class CreateCountryInteractorTests: XCTestCase {
    var sut: CreateCountryListInteractor!
    var presenterSpy: CreateCountryListPresenterSpy!
    var subscription = Set<AnyCancellable>()
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = CreateCountryListInteractor()
        presenterSpy = CreateCountryListPresenterSpy()
    }
    
    // MARK: - Test doubles
    class CreateCountryListPresenterSpy: CreateCountryListPresentationLogic {
        var presentCountryCalled = false
        var errorMessageCalled = false
        var country: [Country] = []
        
        func presentCountryList(response: CreateCountryList.LoadCountryList.Response) {
            presentCountryCalled = true
            country = response.countryList
        }
        
        func showErrorMessage(message: String) {
            errorMessageCalled = true
        }
    }
    
    
    // MARK: - Tests
    
    
    func testLoadCountryListCallsPresenterToPresentCountryList() {
      // Given
        sut.presenter = presenterSpy
//        let country = Seeds.country
      // When
        let request = CreateCountryList.LoadCountryList.Request()
        let useCase = CreateCountryListUseCaseMock()
        sut.loadCountries(request: request, useCase: useCase)

        // Then
        XCTAssertEqual(request.param.isEmpty, true)
        
        let promise = self.expectation(description: "Fetch Countrylist")
        useCase.fetchCountryList(request: request)
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(_):
                    XCTFail()
                }
            } receiveValue: { countryList in
                if countryList.count == 1 {
                    promise.fulfill()
                }
            }.store(in: &subscription)
        wait(for: [promise], timeout: 2)
    }

    override func tearDownWithError() throws {
        sut = nil
        presenterSpy = nil
        subscription = []
        try super.tearDownWithError()
    }
}
