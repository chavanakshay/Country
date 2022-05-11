//
//  CreateProvinceListPresenter.swift
//  Country
//
//  Created by a.diliprao.chavan on 10/05/22.
//

import Foundation

protocol CreateProvinceListPresentationLogic{
    func presentProvinceList(response:CreateProvinceList.LoadProvinceList.Response)
    func showErrorMessage(message:String)
}

final class CreateProvinceListPresenter{
    var view:CreateProvinceListDisplayProtocol?
}

extension CreateProvinceListPresenter:CreateProvinceListPresentationLogic{
    func showErrorMessage(message: String) {
        //Pass the error to view
        view?.displayError(message: message)
    }
    
    func presentProvinceList(response: CreateProvinceList.LoadProvinceList.Response) {
        //Pass recieved province to decorator
        let list = response.provinceList.compactMap {ProvinceWrapper(object: $0)}
        //Pass the decorated Province to view
        view?.displayProvinceList(response: CreateProvinceList.LoadProvinceList.ViewModel(provinceList: list))
    }
}
