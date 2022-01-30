//
//  APIServiceProtocol.swift
//  SpaceNewsApp
//
//  Created by Руслан Осмаев on 27.01.2022.
//

import Foundation

protocol APIServiceProtocol {
	associatedtype dataType
	
	func get(url: String, queryItem: [String: String]) -> dataType?
	func generateURL(url:String, queryItem: [String:String]?) -> URL?
}
