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
	
//	init()
//	{
//        APIServiceImplementation.shared.getNews()
//            .map {
//                $0.map {
//                    NewsCellModel(imageUrl: NSURL(string: $0.imageURL ?? ""),
//                                  title: $0.title,
//                                  publishedAt: $0.publishedAt,
//                                  newsUrl: NSURL(string: $0.url ?? "")
//                                  )
//                }
//            }
//            .assign(to: \.newsDataSet, on: self)
//            .store(in: &self.cancellableSet)
//	}
	
	func getNews() {
        APIServiceImplementation.shared.getNews()
            .map {
                $0.map {
                    NewsCellModel(imageUrl: NSURL(string: $0.imageURL ?? ""),
                                  title: $0.title,
                                  publishedAt: $0.publishedAt,
                                  newsUrl: NSURL(string: $0.url ?? "")
                                  )
                }
            }
            .assign(to: \.newsDataSet, on: self)
            .store(in: &self.cancellableSet)
	}
}
