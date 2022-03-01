//
//  ResultCityPageViewModel.swift
//  SpaceNewsApp
//
//  Created by Руслан Осмаев on 20.02.2022.
//

import Foundation
import Combine

class ResultCityPageViewModel {
    
    @Published var dataStorage: ResultCitysModel = ResultCitysModel.placeholder
    
    func getCitys(latitude: String, longitude: String, radius: String, minPopulation: String, maxPopulation: String) {
        APIServiceImplementation.shared.getCitiesAroundThePoint(latitude: latitude,
                                                 longitude: longitude,
                                                 radius: radius,
                                                 minPopulation: minPopulation,
                                                 maxPopulation: maxPopulation)
            .assign(to: \.dataStorage, on: self)
            .store(in: &CancellableSetService.shared.set)
    }
}