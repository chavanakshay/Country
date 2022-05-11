//
//  RequestProvider.swift
//  Country
//
//  Created by a.diliprao.chavan on 10/05/22.
//

import Foundation

protocol Provider {
    var param : [String: Any] { get }
    var url : String { get }
}

