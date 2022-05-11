//
//  CreateProvinceListConfigurator.swift
//  Country
//
//  Created by a.diliprao.chavan on 10/05/22.
//


import SwiftUI

extension CreateProvinceListView{
    //connect view interactor and presenter
    func configureView() -> some View {
        var view = self
        let interactor = CreateProvinceListInteractor()
        let presenter = CreateProvinceListPresenter()
        view.interactor = interactor
        interactor.presenter = presenter
        presenter.view = view
        return view
    }
}
