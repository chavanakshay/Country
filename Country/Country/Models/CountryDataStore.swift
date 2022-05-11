//
//  CountryDataStore.swift
//  Country
//
//  Created by a.diliprao.chavan on 09/05/22.
//

import Foundation

struct CountryWrapper{
    let id:Int!
    let name:String!
    private let code:String?
    private let phoneCode:String?
    
    init(object:Country) {
        self.id = object.iD
        self.name = object.name
        self.code = object.code
        self.phoneCode = object.phoneCode
    }
    
    var formattedCode:String{
        guard let code = code else {
            return ""
        }
        return "Code: \(code)"
    }
    
    var formattedPhoneCode:String{
        guard let code = phoneCode else {
            return ""
        }
        return "Phone code: \(code)"
    }
}

class CountryDataStore:ObservableObject{
    @Published var countryList:[CountryWrapper] = []
    @Published var errorMessage:String = ""
    @Published var shouldShowProgressView:Bool = false
}
