//
//  BreakingNewsViewModel.swift
//  SpaceNewsApp
//
//  Created by Руслан Осмаев on 10.02.2022.
//

import Foundation
import Combine
import UIKit

class BreakingNewsViewModel {
//    var imageLoaderService: ImageCacheService!
//    @Published var newsImage: UIImage? = UIImage()
    @Published var newsInfo: String? = ""
    
    func getNewsInfo(newsUrl: URL, newsId: Int) {
        APIServiceImplementation.shared.getNewsDescription(url: newsUrl, newsId: newsId)
            .sink(receiveValue: { [weak self] description in
                self?.newsInfo = description
            })
            .store(in: &CancellableSetService.set)
    }
    
//    func getNewsPhoto(imageUrl: URL) {
//        imageLoaderService.loadImage(url: imageUrl)
//            .sink { error in
//                debugPrint(error)
//            } receiveValue: { [weak self] image in
//                self?.newsImage = image
//            }
//            .store(in: &CancellableSetService.set)

//        ImageLoaderService.shared.loadImageForBreakingNews(url: imageUrl) { [weak self] result in
//            switch result {
//            case .success(let image):
//                DispatchQueue.main.async {
//                    self?.newsImage = image
//                }
//            case .failure(let error):
//                print(error)x
//            }
//        }
//    }
    
    func clearNewsTextInfo() {
        newsInfo = ""
    }
}
