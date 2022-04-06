//
//  VideosListModel.swift
//  SpaceNewsApp
//
//  Created by Руслан Осмаев on 27.02.2022.
//

import Foundation

// MARK: - VideosListModel
struct VideoServerModel: Codable {
    let kind, etag, nextPageToken, prevPageToken, regionCode: String?
    let pageInfo: PageInfo?
    let items: [VideoItem]?
}

// MARK: - Item
struct VideoItem: Codable {
    let kind, etag: String?
    let id: ID?
    let snippet: Snippet?
    
    static let placeholder = VideoItem(kind: nil,
                                       etag: nil,
                                       id: nil,
                                       snippet: nil)
}

// MARK: - ID
struct ID: Codable {
    let kind, videoID: String?

    enum CodingKeys: String, CodingKey {
        case kind
        case videoID = "videoId"
    }
}

// MARK: - Snippet
struct Snippet: Codable {
    let publishedAt: String?
    let channelID, title, snippetDescription: String?
    let thumbnails: Thumbnails?
    let channelTitle, liveBroadcastContent: String?
    let publishTime: String?

    enum CodingKeys: String, CodingKey {
        case publishedAt
        case channelID = "channelId"
        case title
        case snippetDescription = "description"
        case thumbnails, channelTitle, liveBroadcastContent, publishTime
    }
}

// MARK: - Thumbnails
struct Thumbnails: Codable {
    let thumbnailsDefault, medium, high: Default?

    enum CodingKeys: String, CodingKey {
        case thumbnailsDefault = "default"
        case medium, high
    }
}

// MARK: - Default
struct Default: Codable {
    let url: String?
    let width, height: Int?
}

// MARK: - PageInfo
struct PageInfo: Codable {
    let totalResults, resultsPerPage: Int?
}

