//
//  CreateProvinceListView.swift
//  Country
//
//  Created by a.diliprao.chavan on 10/05/22.
//

import SwiftUI

protocol CreateProvinceListDisplayProtocol{
    func displayProvinceList(response:CreateProvinceList.LoadProvinceList.ViewModel)
    func displayError(message:String)
}

struct CreateProvinceListView: View {
    var countryId:String
    var interactor:CreateProvinceListBusinessLogic?
    @ObservedObject var dataStore:ProvinceDataStore = ProvinceDataStore()
    
    var body: some View {
        VStack{
            if self.dataStore.errorMessage.isEmpty == false{
                Spacer()
                Text(self.dataStore.errorMessage)
                    .foregroundColor(.red)
                    .fontWeight(.semibold)
                    .multilineTextAlignment(.center)
                Button(Constant.RETRY) {
                    fetchProvinceList(id: countryId)
                }
                .padding(.top,40)
                Spacer()
            }else{
                ScrollView{
                    ScrollViewReader { reader in
                        pullToRefreshView
                        LazyVStack{
                            ForEach(dataStore.provinceList, id: \.id) {
                                ProvinceCell(province: $0)
                            }
                        }
                    }
                }
                .coordinateSpace(name: "pullToRefresh")
            }
        }
        .navigationTitle(Constant.PROVINCE)
        .showProgressView(shouldShow: $dataStore.shouldShowProgressView)
        .onAppear {
            fetchProvinceList(id: countryId)
        }
    }
    
    private var pullToRefreshView: some View {
        PullToRefresh(coordinateSpaceName: "pullToRefresh", showLoader: $dataStore.shouldShowProgressView, tint: .black ,onPull: {
            fetchProvinceList(id: countryId)
        }).id("progress_indicator")
    }
}

struct CreateProvinceListView_Previews: PreviewProvider {
    static var previews: some View {
        CreateProvinceListView(countryId: "104")
    }
}


extension CreateProvinceListView:CreateProvinceListDisplayProtocol{
    
    func displayError(message: String) {
        self.dataStore.errorMessage = message
        dataStore.shouldShowProgressView = false
    }
    
    func displayProvinceList(response: CreateProvinceList.LoadProvinceList.ViewModel) {
        dataStore.provinceList = response.provinceList
        dataStore.shouldShowProgressView = false
    }
    
    func fetchProvinceList(id:String){
        dataStore.shouldShowProgressView = true
        dataStore.errorMessage = ""
        let request = CreateProvinceList.LoadProvinceList.Request.province(id: id)
        interactor?.loadProvince(request: request)
    }
}
