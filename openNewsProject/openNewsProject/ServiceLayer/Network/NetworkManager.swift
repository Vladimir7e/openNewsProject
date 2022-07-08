//
//  NetworkManager.swift
//  openNewsProject
//
//  Created by Developer on 26.06.2022.
//

import Foundation
import Alamofire

protocol NetworkManagerProtocol {
    var url: String { get }
    func loadData<T: Decodable>(url: URL, completion: @escaping (Result<T, AFError>) -> Void)
}

final class NetworkManager: NetworkManagerProtocol {
    private let key: String = "QaKo5gh1MsmpKH6vOU3L1mwjiZsCOx20"
    private let parameter: String = "api-key"
    let url: String = "https://api.nytimes.com/svc/mostpopular/v2"
    
    func loadData<T: Decodable>(url: URL, completion: @escaping (Result<T, AFError>) -> Void) {
        guard var urlComponents = URLComponents(string: url.absoluteString) else { return }
        let accessQuerryItem: URLQueryItem = URLQueryItem(name: parameter, value: key)
        urlComponents.queryItems = [accessQuerryItem]
        let request: DataRequest = AF.request(urlComponents)
        request.responseDecodable(of: T.self) { response in
            completion(response.result)
        }
    }
}
