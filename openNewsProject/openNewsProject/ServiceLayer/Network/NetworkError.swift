//
//  NetworkError.swift
//  openNewsProject
//
//  Created by Developer on 13.07.2022.
//

import Foundation
import Alamofire
import SwiftUI

extension NetworkError: ErrorItemProtocol {
    var title: String? {
        return R.string.localizable.error()
    }
    var message: String? {
        return errorDescription
    }
}

enum NetworkError: LocalizedError {
    case network(AFError)
    case server(ServerError)

    var errorDescription: String? {
        switch self {
        case .network(let afError):
            return afError.underlyingError?.localizedDescription
        case .server(let error):
            return error.errorDescription
        }
    }
}

struct ServerError: LocalizedError {
    let errorDescription: String?
}
