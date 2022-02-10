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
    
    func getNewsDescription(url: URL) -> AnyPublisher<String, Never> {
        let descriptionSeverUrl = "http://localhost:80/description/"
        guard let localURL = generateURL(url: descriptionSeverUrl, queryItem: ["url": url.description]) else {
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
            // Check for the error, then data and try to create the image.
            guard let responseData = data, let image = UIImage(data: responseData), error == nil else {
                DispatchQueue.main.async {
                    completion(fetchedItem, nil)
                }
                return
            }
            // Кэшировние изображения
            ImageCache.shared.cachedImages.setObject(image, forKey: imageUrl as NSURL, cost: responseData.count)
            DispatchQueue.main.async {
                completion(fetchedItem, image)
            }
        }
        .resume()
    }
    
    func getImageForBreakingNews(imageUrl: URL, completion: @escaping (Result<UIImage, Error>) -> ()) {
        URLSession.shared.dataTask(with: imageUrl) { (data, response, error) in
            // Check for the error, then data and try to create the image.
            guard let responseData = data, let image = UIImage(data: responseData),
                error == nil else {
                    if let error = error {
                        completion(.failure(error))
                    }
                    return
            }
            // Кэшировние изображения
            ImageCache.shared.cachedImages.setObject(image, forKey: imageUrl as NSURL, cost: responseData.count)
            // Проход по всем completion блокам для их выполнения
            completion(.success(image))
        }.resume()
    }
}
