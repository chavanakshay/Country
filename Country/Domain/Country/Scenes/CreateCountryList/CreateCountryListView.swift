//
//  CreateCountryListView.swift
//  Country
//
//  Created by a.diliprao.chavan on 09/05/22.
//

import SwiftUI

protocol CreateCountryListDisplayProtocol{
    func displayCountryList(response:CreateCountryList.LoadCountryList.ViewModel)
    func displayError(message:String)
}

struct CreateCountryListView: View {
    var interactor:CreateCountryListBusinessLogic?
    @ObservedObject var dataStore:CountryDataStore = CountryDataStore()
    
    var body: some View {
        NavigationView{
            VStack{
                if self.dataStore.errorMessage.isEmpty == false{
                    Spacer()
                    Text(self.dataStore.errorMessage)
                        .foregroundColor(.red)
                        .fontWeight(.semibold)
                        .multilineTextAlignment(.center)
                    Button("Retry") {
                        fetchCountryList()
                    }
                    .padding(.top,40)
                    Spacer()
                }else{
                    ScrollView{
                        ScrollViewReader { reader in
                            pullToRefreshView
                            LazyVStack{
                                ForEach(dataStore.countryList, id: \.id) { country in
                                    CountryCell(country: country)
                                        .onTapGesture {
                                            NavigationUtil.push(view: CreateProvinceListView(countryId: String(country.id)).configureView())
                                        }
                                  
                                }
                            }
                        }
                    }
                    .coordinateSpace(name: "pullToRefresh")
                }
            }
            .navigationTitle("Country")
            .showProgressView(shouldShow: $dataStore.shouldShowProgressView)
            .onAppear {
                fetchCountryList()
            }
        }
    }
    
    private var pullToRefreshView: some View {
        PullToRefresh(coordinateSpaceName: "pullToRefresh", showLoader: $dataStore.shouldShowProgressView, tint: .black ,onPull: {
            fetchCountryList()
        }).id("progress_indicator")
    }
}

struct CreateCountryListView_Previews: PreviewProvider {
    static var previews: some View {
        CreateCountryListView()
    }
}


extension CreateCountryListView:CreateCountryListDisplayProtocol{
    func displayError(message: String) {
        self.dataStore.errorMessage = message
        dataStore.shouldShowProgressView = false
    }
    
    func displayCountryList(response: CreateCountryList.LoadCountryList.ViewModel) {
        dataStore.countryList = response.countryList
        dataStore.shouldShowProgressView = false
    }
    
    func fetchCountryList(){
        dataStore.shouldShowProgressView = true
        dataStore.errorMessage = ""
        let request = CreateCountryList.LoadCountryList.Request()
        interactor?.loadCountries(request: request, useCase: CountryListUseCase())
    }
}



