//
//  CountryDetailsUseCase.swift
//  Country
//
//  Created by a.diliprao.chavan on 10/05/22.
//

import Foundation
import Combine

protocol CountryDetailsUseCaseProtocol{
    func fetchCountryDetails(request:Provider) -> AnyPublisher<[Province], Error>
}



class CountryDetailsUseCase : CountryDetailsUseCaseProtocol{
    var restClient: RestAPIClientProtocol = RestAPIClient()
    
    func fetchCountryDetails(request:Provider) -> AnyPublisher<[Province], Error>{
        restClient.get(request: request, decode: [Province].self)
    }
}
