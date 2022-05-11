//
//  CountryListUseCaseMock.swift
//  CountryTests
//
//  Created by a.diliprao.chavan on 10/05/22.
//

import Combine
@testable import Country

class CreateCountryListUseCaseMock:CountryListUseCaseProtocol{
    func fetchCountryList(request: Provider) -> AnyPublisher<[Country], Error> {
        let country = Seeds.country
        return Just([country])
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()

    }
}
