//
//  BodyError.swift
//  openNewsProject
//
//  Created by Developer on 15.07.2022.
//

import Foundation

struct BodyError: Decodable {
    let fault: Faultstring
}

struct Faultstring: Decodable {
    let faultstring: String
}
