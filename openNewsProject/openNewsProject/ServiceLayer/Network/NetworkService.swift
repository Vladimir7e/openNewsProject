//
//  NetworkService.swift
//  openNewsProject
//
//  Created by Developer on 13.05.2022.
//

import Foundation
import Alamofire

protocol EmailedNetworkServiceProtocol {
    func getMostEmailed(completion: @escaping (Result<MostEmailedResponseModel, Error>) -> Void)
    func getMostShared(completion: @escaping (Result<MostEmailedResponseModel, Error>) -> Void)
    func getMostViewed(completion: @escaping (Result<MostEmailedResponseModel, Error>) -> Void)
}

class EmailedNetworkService: EmailedNetworkServiceProtocol {
    func getMostEmailed(completion: @escaping (Result<MostEmailedResponseModel, Error>) -> Void) {
        AF.request("https://api.nytimes.com/svc/mostpopular/v2/emailed/30.json?api-key=QaKo5gh1MsmpKH6vOU3L1mwjiZsCOx20")
          .validate()
          .responseDecodable(of: MostEmailedResponseModel.self) { (response) in
              switch response.result {
              case .success(let mostEmailedResponseModel):
                  completion(.success(mostEmailedResponseModel))
              case .failure(let error):
                  print(error)
              }
          }
    }
    
    func getMostShared(completion: @escaping (Result<MostEmailedResponseModel, Error>) -> Void) {
        AF.request("https://api.nytimes.com/svc/mostpopular/v2/shared/30/facebook.json?api-key=QaKo5gh1MsmpKH6vOU3L1mwjiZsCOx20")
          .validate()
          .responseDecodable(of: MostEmailedResponseModel.self) { (response) in
              switch response.result {
              case .success(let mostEmailedResponseModel):
                  completion(.success(mostEmailedResponseModel))
              case .failure(let error):
                  print(error)
              }
          }
    }
    
    func getMostViewed(completion: @escaping (Result<MostEmailedResponseModel, Error>) -> Void) {
        AF.request("https://api.nytimes.com/svc/mostpopular/v2/viewed/30.json?api-key=QaKo5gh1MsmpKH6vOU3L1mwjiZsCOx20")
          .validate()
          .responseDecodable(of: MostEmailedResponseModel.self) { (response) in
              switch response.result {
              case .success(let mostEmailedResponseModel):
                  completion(.success(mostEmailedResponseModel))
              case .failure(let error):
                  print(error)
              }
          }
    }
}
