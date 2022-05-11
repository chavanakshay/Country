//
//  CreateCountryListConfigurator.swift
//  Country
//
//  Created by a.diliprao.chavan on 09/05/22.
//

import SwiftUI

extension CreateCountryListView{
    //connect view interactor and presenter
    func configureView() -> some View {
        var view = self
        let interactor = CreateCountryListInteractor()
        let presenter = CreateCountryListPresenter()
        view.interactor = interactor
        interactor.presenter = presenter
        presenter.view = view
        return view
    }
}
