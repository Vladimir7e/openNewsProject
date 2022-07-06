//
//  NetworkService.swift
//  openNewsProject
//
//  Created by Developer on 13.05.2022.
//

//import Foundation
//import Alamofire
//
//protocol NewsNetworkServiceProtocol {
//    func getMostNews(type: ModelType, completion: @escaping (Result<NewsResponseModel, AFError>) -> Void)
//}
//
//class NewsNetworkService: NewsNetworkServiceProtocol {
//    private let networkManager = NetworkManager()
//
//    func getMostNews(type pathType: ModelType, completion: @escaping (Result<NewsResponseModel, AFError>) -> Void) {
//        guard let url = URL(string: pathType.path) else {
//            completion(.failure(.invalidURL(url: pathType.path)))
//            return
//        }
//        networkManager.loadData(url: url, completion: completion)
//    }
//}
