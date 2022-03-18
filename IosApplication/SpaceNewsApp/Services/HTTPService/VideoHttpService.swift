//
//  VideoLIstLoader.swift
//  SpaceNewsApp
//
//  Created by Руслан Осмаев on 14.03.2022.
//

import Foundation
import Combine

class VideoHttpService {
    /// Singleton
    static let shared = VideoHttpService()
    
    /// Токет следующей страницы для постраничной загрузки
    var nextPageVideoToken = ""
    
    /// Приватный конструктор для парильной работы singleton
    private init() {}
    
    /// Получение списка видео с канала
    /// - Returns: Список видео
    func getVideos(loadFirstPage: Bool) -> AnyPublisher<[VideoItem], Never> {
        if loadFirstPage {
            nextPageVideoToken = ""
        }
        let url = "https://www.googleapis.com/youtube/v3/search"
        guard let localUrl = HttpHelper.generateURL(
            url: url,
            queryItem:
                [
                    "key": "AIzaSyD4ZVpI4bi4bk3BELNzgH9ZpXWRwyczPHw",
                    "channelId": "UCLA_DiR1FfKNvjuUpBHmylQ",
                    "part": "snippet,id",
                    "order": "date",
                    "maxResults": "20",
                    "pageToken": nextPageVideoToken
                ]) else {
            return Just([VideoItem.placeholder]).eraseToAnyPublisher()
        }
        return URLSession.shared.dataTaskPublisher(for: localUrl)
            .map { $0.data }
            .decode(type: VideoServerModel.self, decoder: JSONDecoder())
            .map {
                self.nextPageVideoToken = $0.nextPageToken ?? ""
                return $0.items ?? [VideoItem.placeholder]
            }
            .catch { error in Just([VideoItem.placeholder]) }
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
    
    func getLiveVideos() -> AnyPublisher<[VideoItem], Never> {
        let url = "https://www.googleapis.com/youtube/v3/search"
        guard let localUrl = HttpHelper.generateURL(
            url: url,
            queryItem:
                [
                    "key": "AIzaSyD4ZVpI4bi4bk3BELNzgH9ZpXWRwyczPHw",
                    "channelId": "UCLA_DiR1FfKNvjuUpBHmylQ",
                    "part": "snippet,id",
                    "order": "date",
                    "eventType": "live",
                    "type": "video"
                ]) else {
            return Just([VideoItem.placeholder]).eraseToAnyPublisher()
        }
        return URLSession.shared.dataTaskPublisher(for: localUrl)
            .map { $0.data }
            .decode(type: VideoServerModel.self, decoder: JSONDecoder())
            .map {
                self.nextPageVideoToken = $0.nextPageToken ?? ""
                return $0.items ?? [VideoItem.placeholder]
            }
            .catch { error in Just([VideoItem.placeholder]) }
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
}
