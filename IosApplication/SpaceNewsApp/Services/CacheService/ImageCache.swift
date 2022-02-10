//
//  ImageCache.swift
//  SpaceNewsApp
//
//  Created by Руслан Осмаев on 09.02.2022.
//

import Foundation
import UIKit

public class ImageCache {
    static let shared = ImageCache()
    
    let cachedImages = NSCache<NSURL, UIImage>()
    private var loadingResponses = [NSURL: [(NewsCellModel, UIImage?) -> Void]]()
    
    
    /// Метод для получение изображения из кэша
    /// - Parameter url: URL изображения
    /// - Returns: Изображение, если оно найдено, или nil в случае, если его нет
    public final func getImageFromCache(url: NSURL) -> UIImage? {
        return cachedImages.object(forKey: url)
    }
    
    /// Метод для загрузки картинки в ленту новостей
    /// - Parameters:
    ///   - url: url картинки
    ///   - fetchedItem: Изменяемый объект
    ///   - completion: Замыкание для изменения объекта
    final func loadImageForTableView(url: NSURL, fetchedItem: NewsCellModel, completion: @escaping (NewsCellModel, UIImage?) -> Void) {
        if let cachedImage = getImageFromCache(url: url) {
            DispatchQueue.main.async {
                completion(fetchedItem, cachedImage)
            }
            return
        }
        //Загрузка изображения
        APIServiceImplementation.shared.getImageForTableView(imageUrl: url as URL,
                                                 fetchedItem: fetchedItem,
                                                 completion: completion)
    }
    
    final func loadImageForBreakingNews(url: URL, completion: @escaping (Result<UIImage, Error>) -> ()) {
        if let cachedImage = getImageFromCache(url: url as NSURL) {
            completion(.success(cachedImage))
        }
        else {
            APIServiceImplementation.shared.getImageForBreakingNews(imageUrl: url, completion: completion)
        }
    }
}
