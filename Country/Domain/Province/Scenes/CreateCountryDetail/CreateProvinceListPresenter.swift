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

class CreateProvinceListPresenter{
    var view:CreateProvinceListDisplayProtocol?
}

extension CreateProvinceListPresenter:CreateProvinceListPresentationLogic{
    func showErrorMessage(message: String) {
        view?.displayError(message: message)
    }
    
    func presentProvinceList(response: CreateProvinceList.LoadProvinceList.Response) {
        let list = response.provinceList.compactMap {ProvinceWrapper(object: $0)}
        view?.displayProvinceList(response: CreateProvinceList.LoadProvinceList.ViewModel(provinceList: list))
    }
}
