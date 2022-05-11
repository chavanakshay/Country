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


final class CreateProvinceListInteractor{
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
                    //recieved error will be passed to presenter
                    self.presenter?.showErrorMessage(message: "\(Constant.FAILURE) \(error.localizedDescription)")
                }
            } receiveValue: { result in
                if result.count == 0 {
                    //recieved error will be passed to presenter
                    self.presenter?.showErrorMessage(message: Constant.NO_PROVINCE)
                }else{
                    //fetched province will be passed to presenter
                    self.presenter?.presentProvinceList(response: CreateProvinceList.LoadProvinceList.Response(provinceList: result))
                }
            }.store(in: &store)
    }
}
