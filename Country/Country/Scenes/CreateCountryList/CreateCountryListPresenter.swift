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

final class CreateCountryListPresenter{
    var view:CreateCountryListDisplayProtocol?
}

extension CreateCountryListPresenter:CreateCountryListPresentationLogic{
    func showErrorMessage(message: String) {
        //Pass the error to view
        view?.displayError(message: message)
    }
    
    func presentCountryList(response: CreateCountryList.LoadCountryList.Response) {
        //Pass recieved contries to decorator
        let list = response.countryList.compactMap {CountryWrapper(object: $0)}
        //Pass the decorated Contries to view
        view?.displayCountryList(response: CreateCountryList.LoadCountryList.ViewModel(countryList: list))
    }
}
