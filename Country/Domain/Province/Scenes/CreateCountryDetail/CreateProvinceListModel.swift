//
//  CreateProvinceListModel.swift
//  Country
//
//  Created by a.diliprao.chavan on 10/05/22.
//

import Foundation

enum CreateProvinceList{
    enum LoadProvinceList{
        
        enum Request:Provider{
            case province(id:String)
            var param: [String : Any]{
                switch self {
                case .province(let id):
                    return ["id":id]
                }
            }
            var url: String{
                switch self {
                case .province(let id):
                    return BASE_URL + "rest/worldregions/country/\(id)/province"
                }
            }
        }
        
        struct Response{
            var provinceList:[Province]
        }
        
        struct ViewModel{
            var provinceList:[ProvinceWrapper]
        }
    }
}
