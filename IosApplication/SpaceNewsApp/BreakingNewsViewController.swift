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

protocol DetailButtonDelegate: AnyObject {
    func detailButtonHandler()
}

class BreakingNewsViewController: UIViewController {
	
    var breakingNewsViewModel: BreakingNewsViewModel!
    
    var breakingNewsView = BreakingNewsView()
    
    let detailView = MoreButtonView()
    
    var isDetailPresent = false
    
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
        breakingNewsView.detailButtonDelegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        breakingNewsView.newsImage.loadImage(from: imageURL as NSURL)
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
            .$newsInfo
            .assign(to: \.breakingNewsView.newsInfo.text, on: self)
            .store(in: &CancellableSetService.set)
    }
}

extension BreakingNewsViewController: MoreViewButtonDelegate, DetailButtonDelegate {
    func addFavoriteHandler() {
        print("addFavorite")
    }
    
    func readTextHandler() {
        print("readText")
    }
    
    func detailButtonHandler() {
        if !isDetailPresent {
            isDetailPresent = true
            detailView.frame = CGRect(x: view.frame.midX,
                                      y: breakingNewsView.detailBtn.frame.maxY + 10,
                                      width: breakingNewsView.detailBtn.frame.maxX - view.frame.midX,
                                      height: 80)
            detailView.alpha = 0
            view.addSubview(detailView)
            UIView.animate(withDuration: 0.3) {
                self.detailView.alpha = 1
            }
        }
        else {
            isDetailPresent = false
            UIView.animate(withDuration: 0.3) {
                self.detailView.alpha = 0
            } completion: { _ in
                self.detailView.removeFromSuperview()
            }
        }
    }
}
