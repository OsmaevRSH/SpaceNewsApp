//
//  CurrentCityServerModel.swift
//  SpaceNewsApp
//
//  Created by Руслан Осмаев on 23.03.2022.
//
import Foundation

// MARK: - CityDetailElement
struct CurrentCityServerModel: Codable {
    let city: String?
    let population: Int?
    let latitude: Double?
    let longitude: Double?
    let country: String?
    let countryId: String?
    let timeZoneId: String?
    let timeZoneName: String?
    let timeZoneGmtOffset: Int?
    let localTimeNow: String?
    let distance: Double?
    let bearing: Double?
    let compassDirection: String?

    enum CodingKeys: String, CodingKey {
        case city = "City"
        case population = "Population"
        case latitude = "Latitude"
        case longitude = "Longitude"
        case country = "Country"
        case countryId = "CountryId"
        case timeZoneId = "TimeZoneId"
        case timeZoneName = "TimeZoneName"
        case timeZoneGmtOffset = "TimeZone_GMT_offset"
        case localTimeNow = "LocalTimeNow"
        case distance = "Distance"
        case bearing = "Bearing"
        case compassDirection = "CompassDirection"
    }
    
    static let placeholder = CurrentCityServerModel(
        city: nil,
        population: nil,
        latitude: nil,
        longitude: nil,
        country: nil,
        countryId: nil,
        timeZoneId: nil,
        timeZoneName: nil,
        timeZoneGmtOffset: nil,
        localTimeNow: nil,
        distance: nil,
        bearing: nil,
        compassDirection: nil)
}
