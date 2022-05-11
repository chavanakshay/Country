//
//  CreateCountryListInteractor.swift
//  Country
//
//  Created by a.diliprao.chavan on 09/05/22.
//

import Foundation
import Combine

protocol CreateCountryListBusinessLogic{
    func loadCountries(request:CreateCountryList.LoadCountryList.Request, useCase:CountryListUseCaseProtocol)
}

class CreateCountryListInteractor{
    var store = Set<AnyCancellable>()
    var presenter:CreateCountryListPresentationLogic?
}

extension CreateCountryListInteractor:CreateCountryListBusinessLogic{
    
    func loadCountries(request: CreateCountryList.LoadCountryList.Request,useCase:CountryListUseCaseProtocol) {
        useCase.fetchCountryList(request: request)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .finished: break
                case .failure(let error):
                    self.presenter?.showErrorMessage(message: "❗️ failure: \(error.localizedDescription)")
                }
            } receiveValue: { result in
                if result.count == 0 {
                    self.presenter?.showErrorMessage(message: "No country available")
                }else{
                    self.presenter?.presentCountryList(response: CreateCountryList.LoadCountryList.Response(countryList: result))
                }
            }.store(in: &store)
    }
}
