//
//  ResultCitysModel.swift
//  SpaceNewsApp
//
//  Created by Руслан Осмаев on 20.02.2022.
//

import Foundation

// MARK: - CityInAreaServerModel
struct CityInAreaServerModel: Codable {
    let data: [CityInfo]?
    let links: [Link]?
    let metadata: Metadata?

    enum CodingKeys: String, CodingKey {
        case data = "data"
        case links = "links"
        case metadata = "metadata"
    }
    
    static let placeholder = CityInAreaServerModel(data: nil, links: nil, metadata: nil)
}

// MARK: - Datum
struct CityInfo: Codable {
    let id: Int?
    let wikiDataId: String?
    let type: String?
    let city: String?
    let name: String?
    let country: String?
    let countryCode: String?
    let region: String?
    let regionCode: String?
    let latitude: Double?
    let longitude: Double?
    let population: Int?
    let distance: Double?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case wikiDataId = "wikiDataId"
        case type = "type"
        case city = "city"
        case name = "name"
        case country = "country"
        case countryCode = "countryCode"
        case region = "region"
        case regionCode = "regionCode"
        case latitude = "latitude"
        case longitude = "longitude"
        case population = "population"
        case distance = "distance"
    }
}

// MARK: - Link
struct Link: Codable {
    let rel: String?
    let href: String?

    enum CodingKeys: String, CodingKey {
        case rel = "rel"
        case href = "href"
    }
}

// MARK: - Metadata
struct Metadata: Codable {
    let currentOffset: Int?
    let totalCount: Int?

    enum CodingKeys: String, CodingKey {
        case currentOffset = "currentOffset"
        case totalCount = "totalCount"
    }
}

