//
//  APIServiceImplementation.swift
//  SpaceNewsApp
//
//  Created by Руслан Осмаев on 27.01.2022.
//

import Foundation
import UIKit
import Combine

class APIServiceImplementation : APIServiceProtocol {
	static let shared = APIServiceImplementation()
    var nextPageVideoToken = ""
    
    private init() {}
	
    func getNews(newsOffset: Int) -> AnyPublisher<[NewsModel], Never> {
		let newsURL = "https://api.spaceflightnewsapi.net/v3/articles"
        guard let localURL = generateURL(url: newsURL, queryItem: ["_limit": "20", "_start": "\(newsOffset)"]) else {
			return Just([NewsModel.placeholder]).eraseToAnyPublisher()
		}
		return URLSession.shared.dataTaskPublisher(for: localURL)
			.map { $0.data }
			.decode(type: [NewsModel].self, decoder: JSONDecoder())
			.catch { error in Just([NewsModel.placeholder])}
			.receive(on: RunLoop.main)
			.eraseToAnyPublisher()
	}
    
    func getNewsDescription(url: URL, newsId: Int) -> AnyPublisher<String, Never> {
        let descriptionSeverUrl = "http://localhost:80/description/"
        guard let localURL = generateURL(url: descriptionSeverUrl, queryItem: ["url": url.description, "news_id": "\(newsId)"]) else {
            return Just("").eraseToAnyPublisher()
        }
        return URLSession.shared.dataTaskPublisher(for: localURL)
            .map { $0.data }
            .decode(type: String.self, decoder: JSONDecoder())
            .catch { error in Just("") }
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
	
	func generateURL(url: String, queryItem: [String : String]?) -> URL? {
		guard let localURL = URL(string: url) else { return nil }
		
		var urlComponent = URLComponents(url: localURL, resolvingAgainstBaseURL: true)
        urlComponent?.queryItems = []
		
		queryItem?.forEach({ (key: String, value: String) in
			urlComponent?.queryItems?.append(URLQueryItem(name: key, value: value))
		})
		return urlComponent?.url
	}
    
    func getImageForTableView(imageUrl: URL, fetchedItem: NewsCellModel, completion: @escaping (NewsCellModel, UIImage?) -> Void) {
        URLSession.shared.dataTask(with: imageUrl) { (data, response, error) in
            guard let responseData = data, let image = UIImage(data: responseData), error == nil else {
                DispatchQueue.main.async {
                    completion(fetchedItem, nil)
                }
                return
            }
            ImageCache.shared.cachedImages.setObject(image, forKey: imageUrl as NSURL, cost: responseData.count)
            DispatchQueue.main.async {
                completion(fetchedItem, image)
            }
        }
        .resume()
    }
    
    func getImageForBreakingNews(imageUrl: URL, completion: @escaping (Result<UIImage, Error>) -> ()) {
        URLSession.shared.dataTask(with: imageUrl) { (data, response, error) in
            guard let responseData = data, let image = UIImage(data: responseData), error == nil else {
                if let error = error {
                    completion(.failure(error))
                }
                return
            }
            ImageCache.shared.cachedImages.setObject(image, forKey: imageUrl as NSURL, cost: responseData.count)
            completion(.success(image))
        }.resume()
    }
    
    func getCitiesAroundThePoint(latitude: String,
                  longitude: String,
                  radius: String,
                  minPopulation: String,
                  maxPopulation: String) -> AnyPublisher<ResultCitysModel, Never> {
        guard let url = generateURL(url: "http://localhost:80/testApi/", queryItem: [ //TODO
            "latitude": latitude,
            "longitude": longitude,
            "radius": radius,
            "min_population": minPopulation,
            "max_population": maxPopulation
        ]) else {
            return Just(ResultCitysModel.placeholder).eraseToAnyPublisher()
        }
        return URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: ResultCitysModel.self, decoder: JSONDecoder())
            .catch { error in Just(ResultCitysModel.placeholder) }
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
    
    func getAListOfVideos() -> AnyPublisher<[VideoItem], Never> {
        let url = "https://www.googleapis.com/youtube/v3/search"
        guard let localUrl = generateURL(
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
            .decode(type: VideosListModel.self, decoder: JSONDecoder())
            .map {
                self.nextPageVideoToken = $0.nextPageToken ?? ""
                return $0.items ?? [VideoItem.placeholder]
            }
            .catch { error in Just([VideoItem.placeholder]) }
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
}
