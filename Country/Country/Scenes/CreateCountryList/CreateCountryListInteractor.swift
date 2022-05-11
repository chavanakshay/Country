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

final class CreateCountryListInteractor{
    var store = Set<AnyCancellable>()
    var presenter:CreateCountryListPresentationLogic?
}

extension CreateCountryListInteractor:CreateCountryListBusinessLogic{
    
    func loadCountries(request: CreateCountryList.LoadCountryList.Request,useCase:CountryListUseCaseProtocol) {
        useCase.fetchCountryList(request: request)
            .receive(on: DispatchQueue.main) //Receiving it on main thread
            .sink { completion in
                switch completion {
                case .finished: break
                case .failure(let error):
                    //recieved error will be passed to presenter
                    self.presenter?.showErrorMessage(message: "\(Constant.FAILURE) \(error.localizedDescription)")
                }
            } receiveValue: { result in
                if result.count == 0 {
                    //recieved error will be passed to presenter
                    self.presenter?.showErrorMessage(message: Constant.NO_COUNTRY)
                }else{
                    //fetched countries will be passed to presenter
                    self.presenter?.presentCountryList(response: CreateCountryList.LoadCountryList.Response(countryList: result))
                }
            }.store(in: &store)
    }
}
