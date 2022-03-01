//
//  BreakingNewsViewController.swift
//  SpaceNewsApp
//
//  Created by Руслан Осмаев on 02.02.2022.
//

import UIKit
import Combine

class BreakingNewsViewController: UIViewController {
	
    var breakingNewsViewModel: BreakingNewsViewModel!
    
    private var breakingNewsView = BreakingNewsView()
    
    private var imageURL: URL!
    private var newsURL: URL!
    private var newsId: Int!
    
    func setupFields(titleViewName: String, newsURL: URL, imageURL: URL, newsId: Int) {
        self.imageURL = imageURL
        self.newsURL = newsURL
        self.newsId = newsId
        self.title = titleViewName
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        binding()
        breakingNewsViewModel.getNewsPhoto(imageUrl: imageURL)
        breakingNewsViewModel.getNewsInfo(newsUrl: newsURL, newsId: newsId)
    }
	
	override func loadView() {
		view = breakingNewsView
	}
    
    private func binding() {
        breakingNewsViewModel
            .$newsImage
            .assign(to: \.breakingNewsView.newsImage.image, on: self)
            .store(in: &CancellableSetService.shared.set)
        breakingNewsViewModel
            .$newsInfo
            .assign(to: \.breakingNewsView.newsInfo.text, on: self)
            .store(in: &CancellableSetService.shared.set)
    }
}
