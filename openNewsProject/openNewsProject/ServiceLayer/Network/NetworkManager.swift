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
    func loadData<T: Decodable>(url: URL, completion: @escaping (Result<T, NetworkError>) -> Void)
}

final class NetworkManager: NetworkManagerProtocol {
    private let parser: IParser = Parser()
    private let key: String = "QaKo5gh1MsmpKH6vOU3L1mwjiZsCOx20"
    private let parameter: String = "api-key"
    let url: String = "https://api.nytimes.com/svc/mostpopular/v2"
    
    func loadData<T: Decodable>(url: URL, completion: @escaping (Result<T, NetworkError>) -> Void) {
        guard var urlComponents = URLComponents(string: url.absoluteString) else { return }
        let accessQuerryItem: URLQueryItem = URLQueryItem(name: parameter, value: key)
        urlComponents.queryItems = [accessQuerryItem]
        let request: DataRequest = AF.request(urlComponents)
        request.responseDecodable(of: T.self) { response in
            switch response.result {
            case .success(let result):
                completion(.success(result))
            case .failure(let error):
                switch response.response?.statusCode {
                default:
                    let error: NetworkError = self.handleError(
                        from: error,
                        data: response.data,
                        statusCode: response.response?.statusCode
                    )
                    completion(.failure(error))
                }
            }
        }
    }
    
    private func handleError(from error: AFError, data: Data?, statusCode: Int?) -> NetworkError {
        if let data: Data = data,
           let fault: BodyError = parser.parse(data: data) {
            return .server(.init(errorDescription: fault.fault.faultstring))
        } else {
            return .network(error)
        }
    }
}
