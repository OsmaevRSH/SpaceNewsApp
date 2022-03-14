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
    
    /// Метод для отравки запроса к API для получения списка городов вокруг точки
    /// - Parameters:
    ///   - latitude: Широта
    ///   - longitude: Долгота
    ///   - radius: Радиус поиска
    ///   - minPopulation: Минимальное кол-во жителей
    ///   - maxPopulation: Максимальное кол-во жителей
    /// - Returns: Список всех найденных городов
    func getCitiesAroundThePoint(latitude: String,
                  longitude: String,
                  radius: String,
                  minPopulation: String,
                  maxPopulation: String) -> AnyPublisher<CityServerModel, Never> {
        guard let url = HttpHelper.generateURL(url: "http://localhost:80/testApi/", queryItem: [ //TODO
            "latitude": latitude,
            "longitude": longitude,
            "radius": radius,
            "min_population": minPopulation,
            "max_population": maxPopulation
        ]) else {
            return Just(CityServerModel.placeholder).eraseToAnyPublisher()
        }
        return URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: CityServerModel.self, decoder: JSONDecoder())
            .catch { error in Just(CityServerModel.placeholder) }
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
}
