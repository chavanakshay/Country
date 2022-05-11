//
//  Country.swift
//  Country
//
//  Created by a.diliprao.chavan on 09/05/22.
//

import Foundation

struct Country : Codable {
    let iD : Int?
    let name : String?
    let code : String?
    let phoneCode : String?

    enum CodingKeys: String, CodingKey {

        case iD = "ID"
        case name = "Name"
        case code = "Code"
        case phoneCode = "PhoneCode"
    }
}
