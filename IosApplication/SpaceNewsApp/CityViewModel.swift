//
//  ResultCityPageViewModel.swift
//  SpaceNewsApp
//
//  Created by Руслан Осмаев on 20.02.2022.
//

import Foundation
import Combine

class CityViewModel {
    @Published var dataStorage: [City] = []
    
    @Published var localStorage: [City] = []
    
    func getCitys(latitude: String, longitude: String, radius: String, minPopulation: String, maxPopulation: String) {
        APIServiceImplementation.shared.getCitiesAroundThePoint(latitude: latitude,
                                                 longitude: longitude,
                                                 radius: radius,
                                                 minPopulation: minPopulation,
                                                 maxPopulation: maxPopulation)
            .map { $0.cities }
            .assign(to: \.localStorage, on: self)
            .store(in: &CancellableSetService.set)
    }
    
    init() {
        $localStorage
            .sink { Array in
                self.dataStorage = Array.sorted(by: { lhs, rhs in
                    lhs.distance < rhs.distance
                })
            }
            .store(in: &CancellableSetService.set)
    }
}
