//
//  Parser.swift
//  openNewsProject
//
//  Created by Developer on 15.07.2022.
//

import Foundation

protocol IParser {
    func parse(data: Data) -> BodyError?
}

final class Parser: IParser {
    func parse(data: Data) -> BodyError? {
        let jsonDecoder: JSONDecoder = JSONDecoder.common
        do {
            guard let object: BodyError = try? jsonDecoder.decode(
                BodyError.self, from: data
            ) else {
                return nil
            }
            return object
        }
    }
}
