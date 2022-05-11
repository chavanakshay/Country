//
//  Seed.swift
//  CountryTests
//
//  Created by a.diliprao.chavan on 10/05/22.
//


import XCTest
@testable import Country

enum Seeds {
  static let country = Country(iD: 1, name: "India", code: "IND", phoneCode: "91")
    
    static let province = Province(iD: 1, countryCode: "IND", code: "91", name: "India")
}
