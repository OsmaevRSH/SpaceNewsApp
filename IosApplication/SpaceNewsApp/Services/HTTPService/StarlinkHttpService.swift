//
//  StarlinkDataService.swift
//  ARProject
//
//  Created by Руслан Осмаев on 30.03.2022.
//

import Foundation
import Combine

class StarlinkHttpService {
    static let shared = StarlinkHttpService()
    let starlinkurl = URL(string:"https://api.spacexdata.com/v4/starlink")
    let session = URLSession(configuration: .default)
    
    /// Метод для получения списка всех спутников
    /// - Returns: Список спутников
    public func getStarlinks() -> AnyPublisher<[SpaceXSatilliteModelElement], Never>
    {
        guard let starlinkurl = starlinkurl else {
            return Just([SpaceXSatilliteModelElement.placeholder])
                .eraseToAnyPublisher()
        }
        return session.dataTaskPublisher(for: starlinkurl)
            .map { $0.data }
            .decode(type: [SpaceXSatilliteModelElement].self, decoder: JSONDecoder())
            .catch { error in return Just([SpaceXSatilliteModelElement.placeholder])
                .eraseToAnyPublisher()}
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
}
