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
    
    private let cachedImages = NSCache<NSURL, UIImage>()
    private var loadingResponses = [NSURL: [(NewsCellModel, UIImage?) -> Void]]()
    
    
    /// Метод для получение изображения из кэша
    /// - Parameter url: URL изображения
    /// - Returns: Изображение, если оно найдено, или nil в случае, если его нет
    public final func getImageFromCache(url: NSURL) -> UIImage? {
        return cachedImages.object(forKey: url)
    }
    
    final func loadImage(url: NSURL, fetchedItem: NewsCellModel, completion: @escaping (NewsCellModel, UIImage?) -> Void) {
        if let cachedImage = getImageFromCache(url: url) {
            DispatchQueue.main.async {
                completion(fetchedItem, cachedImage)
            }
            return
        }
        // Если данное изобрадение было запрошено более одного раза, добляем новый обработчик
        if loadingResponses[url] != nil {
            loadingResponses[url]?.append(completion)
            return
        } else {
            loadingResponses[url] = [completion]
        }
        // Загрузка изобрадения
        URLSession.shared.dataTask(with: url as URL) { (data, response, error) in
            // Check for the error, then data and try to create the image.
            guard let responseData = data, let image = UIImage(data: responseData),
                let completionBlocks = self.loadingResponses[url], error == nil else {
                DispatchQueue.main.async {
                    completion(fetchedItem, nil)
                }
                return
            }
            // Кэшировние изображения
            self.cachedImages.setObject(image, forKey: url, cost: responseData.count)
            // Проход по всем completion блокам для их выполнения
            for block in completionBlocks {
                DispatchQueue.main.async {
                    block(fetchedItem, image)
                }
                return
            }
        }.resume()
    }
        
}
