//
//  CreateProvinceListInteractor.swift
//  Country
//
//  Created by a.diliprao.chavan on 10/05/22.
//

import Foundation
import Combine

protocol CreateProvinceListBusinessLogic{
    func loadProvince(request:CreateProvinceList.LoadProvinceList.Request)
}


class CreateProvinceListInteractor{
    var store = Set<AnyCancellable>()
    var presenter:CreateProvinceListPresentationLogic?
}

extension CreateProvinceListInteractor:CreateProvinceListBusinessLogic{
    func loadProvince(request: CreateProvinceList.LoadProvinceList.Request) {
        let useCase:CountryDetailsUseCaseProtocol = CountryDetailsUseCase()
        useCase.fetchCountryDetails(request: request)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .finished: break
                case .failure(let error):
                    self.presenter?.showErrorMessage(message: "❗️ failure: \(error.localizedDescription)")
                }
            } receiveValue: { result in
                if result.count == 0 {
                    self.presenter?.showErrorMessage(message: "No province available")
                }else{
                    self.presenter?.presentProvinceList(response: CreateProvinceList.LoadProvinceList.Response(provinceList: result))
                }
            }.store(in: &store)
    }
}
