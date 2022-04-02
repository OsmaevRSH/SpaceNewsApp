//
//  ARViewModel.swift
//  ARProject
//
//  Created by Руслан Осмаев on 30.03.2022.
//

import Foundation
import Combine

class ARViewModel {
    var cancelSet: Set<AnyCancellable> = []
    
    @Published var starlinkSatillitesInfo = [String: SpaceXSatilliteModelElement]()
    
    init() {
        StarlinkDataService.shared.getStarlinks()
            .sink { [weak self] satillites in
                DispatchQueue.global(qos: .userInitiated).async {
                    self?.starlinkSatillitesInfo = Dictionary(uniqueKeysWithValues: satillites.compactMap {
                        if let _ = $0.latitude,
                           let _ = $0.longitude {
                            return ("\(UUID())", $0)
                        }
                        return nil
                    })
                }
            }
            .store(in: &cancelSet)
    }
}
