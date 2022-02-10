//
//  BreakingNewsViewController.swift
//  SpaceNewsApp
//
//  Created by Руслан Осмаев on 02.02.2022.
//

import UIKit
import Combine

class BreakingNewsViewController: UIViewController {
	
	private var breakingNewsView = BreakingNewsView()
    private var breakingNewsViewModel = BreakingNewsViewModel()
    private var cancellableSet: Set<AnyCancellable> = []

    override func viewDidLoad() {
        super.viewDidLoad()
    }
	
    convenience init(titleViewName: String, newsURL: URL, imageURL: URL) {
		self.init(nibName: nil, bundle: nil)
		self.title = titleViewName
        binding()
        breakingNewsViewModel.getNewsPhoto(imageUrl: imageURL)
        breakingNewsViewModel.getNewsInfo(newsUrl: newsURL)
	}
	
	override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
		super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func loadView() {
		view = breakingNewsView
	}
    
    private func binding() {
        breakingNewsViewModel
            .$newsImage
            .assign(to: \.breakingNewsView.newsImage.image, on: self)
            .store(in: &cancellableSet)
        breakingNewsViewModel
            .$newsInfo
            .assign(to: \.breakingNewsView.newsInfo.text, on: self)
            .store(in: &cancellableSet)
    }
}
