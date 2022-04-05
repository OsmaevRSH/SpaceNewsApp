//
//  CancellableSetService.swift
//  SpaceNewsApp
//
//  Created by Руслан Осмаев on 27.02.2022.
//

import Combine
import Foundation

/// Сервис для хранения издателей
class CancellableSetService {
    static var set: Set<AnyCancellable> = []
}
