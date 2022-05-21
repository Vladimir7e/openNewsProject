//
//  MostEmailed.swift
//  openNewsProject
//
//  Created by Developer on 13.05.2022.
//

import Foundation

struct MostEmailedResponseModel: Decodable {
    let results: [MostEmailed]
}

struct MostEmailed: Decodable {
    let url: String?
    let id: Int
    let type: String?
    let title: String
    let publishedDate: String
    let media: [Media]
    
    enum CodingKeys: String, CodingKey {
        case url
        case id
        case type
        case title
        case publishedDate = "published_date"
        case media
    }
}

struct Media: Decodable {
    let type: String?
    let subtype: String?
    let caption: String?
    let copyright: String?
    let approvedForSyndication: Int?
    let mediaMetadata: [MediaMetadata]
    
    enum CodingKeys: String, CodingKey {
        case type
        case subtype
        case caption
        case copyright
        case approvedForSyndication = "approved_for_syndication"
        case mediaMetadata = "media-metadata"
    }
}

struct MediaMetadata: Decodable {
    let url: String?
    let format: String?
    let height: Int?
    let width: Int?
}
