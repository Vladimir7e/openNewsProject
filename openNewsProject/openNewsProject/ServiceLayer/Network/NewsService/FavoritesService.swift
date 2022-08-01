//
//  FavoritesService.swift
//  openNewsProject
//
//  Created by Developer on 05.07.2022.
//

import Foundation
import Alamofire

class FavoritesService: NewsServiceProtocol {
    private let storage: Storable = Storage()
    
    func getNews(completion: @escaping (Result<NewsResponseModel, NetworkError>) -> Void) {
        var news: [News] = []
        
        storage.fetchData().forEach { model in
            let mediaMetadata: MediaMetadata = .init(url: model.imagePath)
            let media: Media = .init(mediaMetadata: [mediaMetadata])
            
            news.append(
                .init(
                    url: model.url,
                    id: model.id,
                    title: model.title,
                    abstract: model.abstract,
                    publishedDate: model.publishedDate,
                    media: [media]
                )
            )
        }
        
        completion(.success(.init(results: news)))
    }
}
