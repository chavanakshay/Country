//
//  ProvinceDataStore.swift
//  Country
//
//  Created by a.diliprao.chavan on 10/05/22.
//

import Foundation

struct ProvinceWrapper{
    let id:Int!
    let name:String!
    private let code:String?
    private let countryCode:String?
    
    init(object:Province) {
        self.id = object.iD
        self.name = object.name
        self.code = object.code
        self.countryCode = object.countryCode
    }
    
    var formattedCode:String{
        guard let code = code else {
            return ""
        }
        return "Code: \(code)"
    }
    
    var formattedCountryCode:String{
        guard let code = countryCode else {
            return ""
        }
        return "Country code: \(code)"
    }
}

class ProvinceDataStore:ObservableObject{
    @Published var provinceList:[ProvinceWrapper] = []
    @Published var errorMessage:String = ""
    @Published var shouldShowProgressView:Bool = false
}
