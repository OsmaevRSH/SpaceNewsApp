//
//  NewsViewModel.swift
//  SpaceNewsApp
//
//  Created by Руслан Осмаев on 02.02.2022.
//

import Foundation
import Combine

class NewsViewModel {
	
	var cancellableSet: Set<AnyCancellable> = []
	
	@Published var newsDataSet: [NewsCellModel] = []
	
	func getNews(newsOffset: Int) {
        APIServiceImplementation.shared.getNews(newsOffset: newsOffset)
            .map {
                $0.map {
                    NewsCellModel(imageUrl: NSURL(string: $0.imageURL ?? ""),
                                  title: $0.title,
                                  publishedAt: $0.newsSite,
                                  newsUrl: NSURL(string: $0.url ?? ""),
                                  newsId: $0.id ?? 0
                                  )
                }
            }
            .assign(to: \.newsDataSet, on: self)
            .store(in: &self.cancellableSet)
	}
}
