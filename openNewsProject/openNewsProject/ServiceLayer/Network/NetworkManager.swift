//
//  NetworkManager.swift
//  openNewsProject
//
//  Created by Developer on 26.06.2022.
//

import Foundation
import Alamofire

class NetworkManager {
    
    private let key = "QaKo5gh1MsmpKH6vOU3L1mwjiZsCOx20"
    private let parameterName = "api-key"
    private let scheme = "https"
    private let host = "api.nytimes.com"
    
    func loadData<T: Decodable>(url: URL, completion: @escaping (Result<T, AFError>) -> Void) {
        guard var urlComponents = URLComponents(string: url.absoluteString) else { return }
        urlComponents.scheme = scheme
        urlComponents.host = host
        let accessQuerryItem = URLQueryItem(name: parameterName, value: key)
        urlComponents.queryItems = [accessQuerryItem]
        let request = AF.request(urlComponents)
        request.responseDecodable(of: T.self) { response in
            completion(response.result)
        }
    }
}
