//
//  NetworkService.swift
//  openNewsProject
//
//  Created by Developer on 13.05.2022.
//

import Foundation
import Alamofire

enum PathType: String {
    case pathEmailed
    case pathShared
    case pathViewed
    
    var path: String {
        switch self {
        case .pathEmailed:
            return "/svc/mostpopular/v2/emailed/30.json"
        case .pathShared:
            return "/svc/mostpopular/v2/shared/30.json"
        case .pathViewed:
            return "/svc/mostpopular/v2/viewed/30.json"
        }
    }
}

protocol NewsNetworkServiceProtocol {
    func getMostEShV(type: PathType, completion: @escaping (Result<NewsResponseModel, AFError>) -> Void)
}

class NewsNetworkService: NewsNetworkServiceProtocol {
    private let networkManager = NetworkManager()
    
    func getMostEShV(type pathType: PathType, completion: @escaping (Result<NewsResponseModel, AFError>) -> Void) {
        guard let url = URL(string: pathType.path) else {
            completion(.failure(.invalidURL(url: pathType.path)))
            return
        }
        networkManager.loadData(url: url, completion: completion)
    }
}
