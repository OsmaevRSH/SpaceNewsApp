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
    @Published var newsImage: UIImage? = UIImage()
    @Published var newsInfo: String? = ""
    private var cancellableSet: Set<AnyCancellable> = []
    
    func getNewsInfo(newsUrl: URL) {
        APIServiceImplementation.shared.getNewsDescription(url: newsUrl)
            .sink(receiveValue: { [weak self] description in
                self?.newsInfo = description
            })
            .store(in: &cancellableSet)
    }
    
    func getNewsPhoto(imageUrl: URL) {
        ImageCache.shared.loadImageForBreakingNews(url: imageUrl) { [weak self] result in
            switch result {
            case .success(let image):
                self?.newsImage = image
            case .failure(let error):
                print(error)
            }
        }
    }
}
