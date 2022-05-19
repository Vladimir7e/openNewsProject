//
//  NetworkService.swift
//  openNewsProject
//
//  Created by Developer on 13.05.2022.
//

import Foundation

protocol EmailedNetworkServiceProtocol {
    func getMostEmailed(completion: @escaping (Result<MostEmailedResponseModel, Error>) -> Void)
}

class EmailedNetworkService: EmailedNetworkServiceProtocol {
    func getMostEmailed(completion: @escaping (Result<MostEmailedResponseModel, Error>) -> Void) {
        let UrlString = "https://api.nytimes.com/svc/mostpopular/v2/emailed/7.json?api-key=QaKo5gh1MsmpKH6vOU3L1mwjiZsCOx20"
        guard let url = URL(string: UrlString) else {return}
        
        URLSession.shared.dataTask(with: url) {data, _, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data: Data = data else {
                return
            }

            print(data)
            do {
                let obj = try JSONDecoder().decode(MostEmailedResponseModel.self, from: data)
                completion(.success(obj))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
