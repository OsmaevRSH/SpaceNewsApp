//
//  CancellableSetService.swift
//  SpaceNewsApp
//
//  Created by Руслан Осмаев on 27.02.2022.
//

import Combine
import Foundation

class CancellableSetService {
    static let shared = CancellableSetService()
    var set: Set<AnyCancellable> = []
}
