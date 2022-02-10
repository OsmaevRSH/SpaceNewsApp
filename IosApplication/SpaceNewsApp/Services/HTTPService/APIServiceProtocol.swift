//
//  APIServiceProtocol.swift
//  SpaceNewsApp
//
//  Created by Руслан Осмаев on 27.01.2022.
//

import Foundation
import Combine

protocol APIServiceProtocol {
	func getNews(newsOffset: Int) -> AnyPublisher<[NewsModel], Never>
	func generateURL(url:String, queryItem: [String:String]?) -> URL?
}
