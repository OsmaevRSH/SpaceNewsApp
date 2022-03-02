//
//  CancellableSetService.swift
//  SpaceNewsApp
//
//  Created by Руслан Осмаев on 27.02.2022.
//

import Combine
import Foundation

class CancellableSetService {
    static var set: Set<AnyCancellable> = []
}
