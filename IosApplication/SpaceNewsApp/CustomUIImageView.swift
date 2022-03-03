//
//  CustomUIImageView.swift
//  SpaceNewsApp
//
//  Created by Руслан Осмаев on 02.03.2022.
//

import Foundation
import UIKit

class CustomUIImageView: UIImageView {
    private var task: URLSessionDataTask!
    var imageCacheService = ImageCacheService.shared
    let loadIndicator = UIActivityIndicatorView(style: .large)

    /// Метод для асинхронной загрузи изображения в UIImageView
    /// - Parameter url: url до изображения
    func loadImage(from url: NSURL?) {

        guard let url = url else {
            return
        }

        image = nil
        addSubview(loadIndicator)
        loadIndicator.translatesAutoresizingMaskIntoConstraints = false
        loadIndicator.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        loadIndicator.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
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
