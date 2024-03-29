//
//  ResultCityPageViewModel.swift
//  SpaceNewsApp
//
//  Created by Руслан Осмаев on 20.02.2022.
//

import Foundation
import Combine

class CityViewModel {
    @Published var dataStorage: [CityInfo] = []
    @Published var currentCity: CurrentCityServerModel = CurrentCityServerModel.placeholder
    
    /// Метод для получения городов в радиусе 100 км
    /// - Parameters:
    ///   - latitude: Долгота
    ///   - longitude: Широта
    func getCitys(latitude: String, longitude: String) {
        CityHttpService.shared.getCitysInArea(latitude: latitude, longitude: longitude)
            .sink(receiveValue: { [weak self] city in
                if let data = city.data {
                    self?.dataStorage = data
                }
            })
            .store(in: &CancellableSetService.set)
    }
    
    /// Метод для получения информации о городе по его координатам
    /// - Parameters:
    ///   - latitude: Долгота
    ///   - longitude: Широта
    func getInfoAboutCurrentCity(latitude: String, longitude: String) {
        CityHttpService.shared.getCurrentCityInformation(latitude: latitude, longitude: longitude)
            .sink { [weak self] citys in
                if let city = citys.first {
                    self?.currentCity = city
                }
            }
            .store(in: &CancellableSetService.set)
    }
}
