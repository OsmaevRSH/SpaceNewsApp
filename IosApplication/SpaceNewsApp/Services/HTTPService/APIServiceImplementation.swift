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
	
	func getNews() -> AnyPublisher<[NewsModel], Never> {
		let newsURL = "https://api.spaceflightnewsapi.net/v3/articles"
		guard let localURL = generateURL(url: newsURL, queryItem: nil) else {
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
        guard let localURL = generateURL(url: "http://localhost:80/description/", queryItem: ["url": url.description]) else {
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
}
