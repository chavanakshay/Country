//
//  CreateCountryListPresenter.swift
//  Country
//
//  Created by a.diliprao.chavan on 09/05/22.
//

import Foundation

protocol CreateCountryListPresentationLogic{
    func presentCountryList(response:CreateCountryList.LoadCountryList.Response)
    func showErrorMessage(message:String)
}

class CreateCountryListPresenter{
    var view:CreateCountryListDisplayProtocol?
}

extension CreateCountryListPresenter:CreateCountryListPresentationLogic{
    func showErrorMessage(message: String) {
        view?.displayError(message: message)
    }
    
    func presentCountryList(response: CreateCountryList.LoadCountryList.Response) {
        let list = response.countryList.compactMap {CountryWrapper(object: $0)}
        view?.displayCountryList(response: CreateCountryList.LoadCountryList.ViewModel(countryList: list))
    }
}
