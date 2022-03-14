//
//  HttpHelper.swift
//  SpaceNewsApp
//
//  Created by Руслан Осмаев on 14.03.2022.
//

import Foundation

class HttpHelper {
    
    /// Метод для генерации url с добавлением query items
    /// - Parameters:
    ///   - url: url
    ///   - queryItem: items которые необходимо добавить к url
    /// - Returns: Полученный url c query items
    class func generateURL(url: String, queryItem: [String : String]?) -> URL? {
        guard let localURL = URL(string: url) else { return nil }
        
        var urlComponent = URLComponents(url: localURL, resolvingAgainstBaseURL: true)
        urlComponent?.queryItems = []
        
        queryItem?.forEach({ (key: String, value: String) in
            urlComponent?.queryItems?.append(URLQueryItem(name: key, value: value))
        })
        return urlComponent?.url
    }
}
