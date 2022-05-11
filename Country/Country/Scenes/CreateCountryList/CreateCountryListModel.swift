//
//  CreateCountryListModel.swift
//  Country
//
//  Created by a.diliprao.chavan on 09/05/22.
//

import Foundation

enum CreateCountryList{
    enum LoadCountryList{
        
        struct Request:Provider{
            var param: [String : Any]{
                [:]// API need no param.
            }
            var url: String{
                BASE_URL + "rest/worldregions/country"
            }
        }
        
        struct Response{
            var countryList:[Country]
        }
        
        struct ViewModel{
            var countryList:[CountryWrapper]
        }
    }
}
