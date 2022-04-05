//
//  BreakingNewsViewModel.swift
//  SpaceNewsApp
//
//  Created by Руслан Осмаев on 10.02.2022.
//

import Foundation
import Combine
import UIKit

class BreakingNewsViewModel {
    @Published var newsInfo: String? = ""
    
    
    /// Метод для текста конкретной новости
    /// - Parameters:
    ///   - newsUrl: URL новости
    ///   - newsId: ID новости
    func getNewsInfo(newsUrl: URL, newsId: Int) {
        NewsHttpService.shared.getNewsDescription(url: newsUrl, newsId: newsId)
            .sink(receiveValue: { [weak self] description in
                self?.newsInfo = description
            })
            .store(in: &CancellableSetService.set)
    }
    
    /// Метод для отчищения поля с текстом текущей новости
    func clearNewsTextInfo() {
        newsInfo = ""
    }
}
