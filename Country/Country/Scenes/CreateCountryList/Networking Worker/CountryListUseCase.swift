//
//  CountryListUseCase.swift
//  Country
//
//  Created by a.diliprao.chavan on 10/05/22.
//

import Foundation
import Combine

protocol CountryListUseCaseProtocol{
    func fetchCountryList(request:Provider) -> AnyPublisher<[Country], Error>
}



class CountryListUseCase : CountryListUseCaseProtocol{
    var restClient: RestAPIClientProtocol = RestAPIClient()
    
    func fetchCountryList(request:Provider) -> AnyPublisher<[Country], Error>{
        restClient.get(request: request, decode: [Country].self)
    }
}
