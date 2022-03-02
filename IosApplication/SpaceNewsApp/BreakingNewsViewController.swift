//
//  BreakingNewsViewController.swift
//  SpaceNewsApp
//
//  Created by Руслан Осмаев on 02.02.2022.
//

import UIKit
import Combine

protocol BreakingNewsDelegate: AnyObject {
    func backButtonHandler()
}

class BreakingNewsViewController: UIViewController {
	
    var breakingNewsViewModel: BreakingNewsViewModel!
    
    var breakingNewsView = BreakingNewsView()
    
    private var imageURL: URL!
    private var newsURL: URL!
    private var newsId: Int!
    
    func setupFields(titleViewName: String, newsURL: URL, imageURL: URL, newsId: Int) {
        self.imageURL = imageURL
        self.newsURL = newsURL
        self.newsId = newsId
        breakingNewsView.newsTitle.text = titleViewName
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        binding()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        breakingNewsViewModel.getNewsPhoto(imageUrl: imageURL)
        breakingNewsViewModel.getNewsInfo(newsUrl: newsURL, newsId: newsId)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        breakingNewsView.scrollView.setContentOffset(CGPoint(x: 0.0, y: 0.0), animated: false)
        breakingNewsViewModel.clearNewsTextInfo()
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
