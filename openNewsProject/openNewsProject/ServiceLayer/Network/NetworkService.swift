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

    var pathComponent: String {
        return "/svc/mostpopular/v2/"
    }
    
    var path: String {
        switch self {
        case .pathEmailed:
            return pathComponent + "emailed/30.json"
        case .pathShared:
            return pathComponent + "shared/30.json"
        case .pathViewed:
            return pathComponent + "viewed/30.json"
        }
    }
}

protocol NewsNetworkServiceProtocol {
    func getMostNews(type: PathType, completion: @escaping (Result<NewsResponseModel, AFError>) -> Void)
}

class NewsNetworkService: NewsNetworkServiceProtocol {
    private let networkManager = NetworkManager()
    
    func getMostNews(type pathType: PathType, completion: @escaping (Result<NewsResponseModel, AFError>) -> Void) {
        guard let url = URL(string: pathType.path) else {
            completion(.failure(.invalidURL(url: pathType.path)))
            return
        }
        networkManager.loadData(url: url, completion: completion)
    }
}
