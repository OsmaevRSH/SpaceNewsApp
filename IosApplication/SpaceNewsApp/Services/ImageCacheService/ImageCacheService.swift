//
//  ImageCache.swift
//  SpaceNewsApp
//
//  Created by Руслан Осмаев on 09.02.2022.
//

import Foundation
import UIKit
import Combine

public class ImageCacheService {
    static let shared = ImageCacheService()
    
    private var task: URLSessionDataTask!
    private let cache: NSCache<NSURL, UIImage>
    
    private init() {
        self.cache = NSCache<NSURL, UIImage>()
    }
    
    func getImageFromCache(for url: NSURL) -> UIImage? {
        return cache.object(forKey: url)
    }
    
    func saveImageToCache(for image: UIImage, from url: NSURL) {
        cache.setObject(image, forKey: url)
    }
}
