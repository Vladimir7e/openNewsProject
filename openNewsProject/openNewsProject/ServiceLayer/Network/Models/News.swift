//
//  MostEmailed.swift
//  openNewsProject
//
//  Created by Developer on 13.05.2022.
//

import Foundation

struct NewsResponseModel: Decodable {
    
    let results: [News]
}

struct News: Decodable {
    
    let url: String
    let id: Int
    let title: String
    let publishedDate: String
    let media: [Media]
    
    enum CodingKeys: String, CodingKey {
        case url
        case id
        case title
        case publishedDate = "published_date"
        case media
    }
}

struct Media: Decodable {
    
    let mediaMetadata: [MediaMetadata]
    
    enum CodingKeys: String, CodingKey {
        case mediaMetadata = "media-metadata"
    }
}

struct MediaMetadata: Decodable {
    
    let url: String?
}
