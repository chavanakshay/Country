//
//  Province.swift
//  Country
//
//  Created by a.diliprao.chavan on 10/05/22.
//

import Foundation

struct Province : Codable {
    let iD : Int?
    let countryCode : String?
    let code : String?
    let name : String?

    enum CodingKeys: String, CodingKey {

        case iD = "ID"
        case countryCode = "CountryCode"
        case code = "Code"
        case name = "Name"
    }

}
