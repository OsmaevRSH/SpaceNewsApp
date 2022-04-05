//
//  CityHttpService.swift
//  SpaceNewsApp
//
//  Created by Руслан Осмаев on 14.03.2022.
//

import Foundation
import Combine

class CityHttpService {
    
    /// Singleton
    static let shared = CityHttpService()
    
    /// Приватный конструктор для парильной работы singleton
    private init() {}
    
    /// Метод для отравки запроса к API для получения информации о текущем городе
    /// - Parameters:
    ///   - latitude: Широта
    ///   - longitude: Долгота
    /// - Returns: Текущий ближайший город по координатам
    func getCurrentCityInformation(latitude: String, longitude: String) -> AnyPublisher<[CurrentCityServerModel], Never> {
        guard let url = HttpHelper.generateURL(url: "https://geocodeapi.p.rapidapi.com/GetNearestCities", queryItem: [
            "latitude": latitude,
            "longitude": longitude,
            "range": "0"
        ]) else {
            return Just([CurrentCityServerModel.placeholder]).eraseToAnyPublisher()
        }
        var request = URLRequest(url: url)
        request.setValue("geocodeapi.p.rapidapi.com", forHTTPHeaderField: "X-RapidAPI-Host")
        request.setValue("816c641d6amsh0baed9b87a5d4c9p169f3bjsn0b8e14e432ce", forHTTPHeaderField: "X-RapidAPI-Key")
        return URLSession.shared.dataTaskPublisher(for: request)
            .map { $0.data }
            .decode(type: [CurrentCityServerModel].self, decoder: JSONDecoder())
            .catch { error in Just([CurrentCityServerModel.placeholder]) }
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
    
    /// Метод для получения информации о городах в радиусе 100 км
    /// - Parameters:
    ///   - latitude: Долгота
    ///   - longitude: Широта
    /// - Returns: Список городов
    func getCitysInArea(latitude: String, longitude: String) -> AnyPublisher<CityInAreaServerModel, Never> {
        var localLongitude = ""
        if longitude.contains("-") {
            localLongitude = "\(longitude)"
        }
        else {
            localLongitude = "+\(longitude)"
        }
        
        guard let url = HttpHelper.generateURL(url: "https://wft-geo-db.p.rapidapi.com/v1/geo/locations/\(latitude)\(localLongitude)/nearbyCities", queryItem: [
            "radius": "100",
            "limit": "10"
        ]) else {
            return Just(CityInAreaServerModel.placeholder).eraseToAnyPublisher()
        }
        var request = URLRequest(url: url)
        request.setValue("wft-geo-db.p.rapidapi.com", forHTTPHeaderField: "X-RapidAPI-Host")
        request.setValue("816c641d6amsh0baed9b87a5d4c9p169f3bjsn0b8e14e432ce", forHTTPHeaderField: "X-RapidAPI-Key")
        return URLSession.shared.dataTaskPublisher(for: request)
            .map { $0.data }
            .decode(type: CityInAreaServerModel.self, decoder: JSONDecoder())
            .catch { error in Just(CityInAreaServerModel.placeholder) }
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
}
