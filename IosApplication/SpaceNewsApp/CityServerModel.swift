//
//  ResultCitysModel.swift
//  SpaceNewsApp
//
//  Created by Руслан Осмаев on 20.02.2022.
//
import Foundation

// MARK: - Welcome
struct CityServerModel: Codable {
    let links: Links?
    let page, perPage, totalPages, totalCities: Int
    let cities: [City]
    let radius: Int
    let location: Location?
    let status: String

    enum CodingKeys: String, CodingKey {
        case links, page
        case perPage = "per_page"
        case totalPages = "total_pages"
        case totalCities = "total_cities"
        case cities, radius, location, status
    }
    
    static var placeholder: Self = CityServerModel(links: nil,
                                                    page: 0,
                                                    perPage: 0,
                                                    totalPages: 0,
                                                    totalCities: 0,
                                                    cities: [],
                                                    radius: 0,
                                                    location: nil,
                                                    status: "")
}

// MARK: - City
struct City: Codable {
    let geonameid, population: Int
    let name: String
    let latitude, longitude: Double
    let country: Country
    let division: Division
    let distance: String
}

// MARK: - Country
struct Country: Codable {
    let code: CountryCode
}

enum CountryCode: String, Codable {
    case ru = "RU"
}

// MARK: - Division
struct Division: Codable {
    let code: DivisionCode
    let geonameid: Int
}

enum DivisionCode: String, Codable {
    case ruKlu = "RU-KLU"
    case ruMOS = "RU-MOS"
    case ruMow = "RU-MOW"
}

// MARK: - Links
struct Links: Codable {
    let first, last, next, previous: String
}

// MARK: - Location
struct Location: Codable {
    let latitude, longitude: Double
}
