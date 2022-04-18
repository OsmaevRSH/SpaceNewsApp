//
//  NewsCacheService.swift
//  SpaceNewsApp
//
//  Created by Руслан Осмаев on 02.03.2022.
//

import Foundation

/// Сервис кэширования новостей
public class NewsCacheService {
    static let shared = NewsCacheService()
    
    private var task: URLSessionDataTask!
    private let cache: NSCache<NSURL, NSString>
    
    private init() {
        self.cache = NSCache<NSURL, NSString>()
    }
    
    func getImageFromCache(for url: NSURL) -> NSString? {
        return cache.object(forKey: url)
    }
    
    func saveImageToCache(for text: NSString, from url: NSURL) {
        cache.setObject(text, forKey: url)
    }
    
    func clearCache() {
        self.cache.removeAllObjects()
    }
}
