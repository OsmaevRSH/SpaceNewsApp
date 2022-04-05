//
//  CustomUIImageView.swift
//  SpaceNewsApp
//
//  Created by Руслан Осмаев on 02.03.2022.
//

import Foundation
import UIKit

class CustomUIImageView: UIImageView {
    
    /// Текущая задача
    private var task: URLSessionDataTask!
    
    /// Singleton
    var imageCacheService = ImageCacheService.shared
    
    /// Индикатор загрузки
    let loadIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()

    /// Метод для асинхронной загрузи изображения в UIImageView
    /// - Parameter url: url до изображения
    func loadImage(from url: NSURL?) {

        guard let url = url else {
            return
        }

        image = nil
        addSubview(loadIndicator)
        NSLayoutConstraint.activate([
            loadIndicator.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            loadIndicator.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
       
        loadIndicator.startAnimating()

        if let task = task {
            task.cancel()
        }

        if let cacheImage = imageCacheService.getImageFromCache(for: url) {
            loadIndicator.removeFromSuperview()
            image = cacheImage
            return
        }

        task = URLSession.shared.dataTask(with: url as URL, completionHandler: { [weak self] data, _, error in
            guard
                let data = data,
                let loadedImage = UIImage(data: data)
            else {
                    return
            }
            self?.imageCacheService.saveImageToCache(for: loadedImage, from: url)

            DispatchQueue.main.async {
                self?.loadIndicator.removeFromSuperview()
                self?.image = loadedImage
            }
        })
        task.resume()
    }
}
