//
//  SharedService.swift
//  openNewsProject
//
//  Created by Developer on 05.07.2022.
//

import Foundation
import Alamofire

class SharedService: NewsServiceProtocol {
    private let networkManager: NetworkManagerProtocol = NetworkManager()

    func getNews(completion: @escaping (Result<NewsResponseModel, NetworkError>) -> Void) {
        let path: String = networkManager.url + "/shared/30.json"

        guard let url = URL(string: path) else { return }

        networkManager.loadData(url: url, completion: completion)
    }
}
