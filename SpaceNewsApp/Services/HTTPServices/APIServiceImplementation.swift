//
//  APIServiceImplementation.swift
//  SpaceNewsApp
//
//  Created by Руслан Осмаев on 27.01.2022.
//

import Foundation
import UIKit
import SwiftUI

class APIServiceImplementation<T> : APIServiceProtocol {
	typealias dataType = T
	
	func get(url: String, queryItem: [String : String]) -> T? {
		guard let localURL = generateURL(url: url, queryItem: queryItem) else { return nil }
		return nil
	}
	
	func generateURL(url: String, queryItem: [String : String]?) -> URL? {
		guard let localURL = URL(string: url) else { return nil }
		
		var urlComponent = URLComponents(url: localURL, resolvingAgainstBaseURL: true)
		
		queryItem?.forEach({ (key: String, value: String) in
			urlComponent?.queryItems?.append(URLQueryItem(name: key, value: value))
		})
		return urlComponent?.url
	}
}
