//
//  NewsModel.swift
//  SpaceNewsApp
//
//  Created by Руслан Осмаев on 02.02.2022.
//

import Foundation

	// MARK: - NewsModel
struct NewsModel: Codable {
	typealias dataType = Self
	
	var id: Int?
	var featured: Bool?
	var title, url, imageURL, newsSite: String?
	var summary, publishedAt: String?
	var launches, events: [Event]?
	
	enum CodingKeys: String, CodingKey {
		case id, featured, title, url
		case imageURL = "imageUrl"
		case newsSite, summary, publishedAt
	}
	
	static var placeholder: Self = {
		return NewsModel(id: nil,
						 featured: nil,
						 title: nil,
						 url: nil,
						 imageURL: nil,
						 newsSite: nil,
						 summary: nil,
						 publishedAt: nil,
						 launches: nil,
						 events: nil)
	}()
}

	// MARK: - Event
struct Event: Codable {
	var id, provider: String?
}
