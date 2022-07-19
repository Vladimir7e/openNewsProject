//
//  JSONDecoder.swift
//  openNewsProject
//
//  Created by Developer on 15.07.2022.
//

import Foundation

extension JSONDecoder {
    static let common: JSONDecoder = {
        let decoder: JSONDecoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase

        return decoder
    }()
}
