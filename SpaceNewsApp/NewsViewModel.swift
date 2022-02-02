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
	
	@Published var newsDataSet: [NewsModel] = [NewsModel.placeholder]
	
//	init()
//	{
//		APIServiceImplementation.shared.getNews()
//			.assign(to: \.newsDataSet, on: self)
//			.store(in: &self.cancellableSet)
//	}
	
	func getNews() {
		APIServiceImplementation.shared.getNews()
			.assign(to: \.newsDataSet, on: self)
			.store(in: &self.cancellableSet)
	}
}
