//
//  NewsLoader.swift
//  SpaceNewsApp
//
//  Created by Руслан Осмаев on 14.03.2022.
//

import Foundation
import Combine

class NewsHttpService {
    /// Singleton
    static let shared = NewsHttpService()
    
    /// Приватный конструктор для парильной работы singleton
    private init() {}
    
    /// Метод для получения списка новостей
    /// - Parameter newsOffset: Текущая загружаемся страница
    /// - Returns: Список новостей
    func getNews(newsOffset: Int) -> AnyPublisher<[NewsServerModel], Never> {
        let newsURL = "https://api.spaceflightnewsapi.net/v3/articles"
        guard let localURL = HttpHelper.generateURL(url: newsURL, queryItem: ["_limit": "20", "_start": "\(newsOffset)"]) else {
            return Just([NewsServerModel.placeholder]).eraseToAnyPublisher()
        }
        return URLSession.shared.dataTaskPublisher(for: localURL)
            .map { $0.data }
            .decode(type: [NewsServerModel].self, decoder: JSONDecoder())
            .catch { error in Just([NewsServerModel.placeholder])}
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
    
    /// Метод для получения описания новости
    /// - Parameters:
    ///   - url: URL новости
    ///   - newsId: ID новости
    /// - Returns: Описание новости
    func getNewsDescription(url: URL, newsId: Int) -> AnyPublisher<String, Never> {
        let descriptionSeverUrl = "http://localhost:80/description/"
        guard let localURL = HttpHelper.generateURL(url: descriptionSeverUrl, queryItem: ["url": url.description, "news_id": "\(newsId)"]) else {
            return Just("").eraseToAnyPublisher()
        }
        return URLSession.shared.dataTaskPublisher(for: localURL)
            .map { $0.data }
            .decode(type: String.self, decoder: JSONDecoder())
            .catch { error in Just("") }
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
}
