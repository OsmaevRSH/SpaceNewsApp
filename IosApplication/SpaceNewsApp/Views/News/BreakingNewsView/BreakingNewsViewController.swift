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
    var detailButtonViewController: DetailButtonViewController!
    var breakingNewsView = BreakingNewsView()
    var isDetailPresent = false
    
    /// View для затемнения заднего фона при открытии определенной новости
    lazy var transparentView: UIView = {
        var localView = UIView()
        return localView
    }()
    
    private var imageURL: URL!
    private var newsURL: URL!
    var newsId: Int!
    
    func setupFields(titleViewName: String, newsURL: URL, imageURL: URL, newsId: Int) {
        self.imageURL = imageURL
        self.newsURL = newsURL
        self.newsId = newsId
        breakingNewsView.newsTitle.text = titleViewName
    }
    
    func setupFields(titleViewName: String, newsText: String, newsImage: Data, newsId: Int) {
        self.newsId = newsId
        imageURL = nil
        newsURL = nil
        breakingNewsView.newsTitle.text = titleViewName
        breakingNewsView.newsInfo.text = newsText
        breakingNewsView.newsImage.image = UIImage(data: newsImage)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        binding()
        breakingNewsView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard let newsURL = newsURL, let imageURL = imageURL else { return }
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
    
    func showBreakingNews() {
        /// Получаем текщее окно
        let window = UIApplication.shared.connectedScenes
            .flatMap{ ($0 as? UIWindowScene)?.windows ?? [] }
            .first{ $0.isKeyWindow }
        
        guard let window = window else {
            return
        }
        
        /// Рассчитываем высоту окна конкретной новости
        let newsViewHeight = window.safeAreaLayoutGuide.layoutFrame.height - 32
        
        /// Устанавливаем положение и размер окна конкретной новости
        self.view.frame = CGRect(x: window.safeAreaLayoutGuide.layoutFrame.origin.x + 16,
                                         y: window.safeAreaLayoutGuide.layoutFrame.origin.y + 16,
                                         width: window.safeAreaLayoutGuide.layoutFrame.width - 32,
                                         height: newsViewHeight)
        
        self.view.alpha = 0
        
        /// Задаем параметры для затемняющего view
        transparentView.frame = window.frame
        transparentView.backgroundColor = .black.withAlphaComponent(0.9)
        transparentView.alpha = 0

        /// Устновка параметров анимации появления конкретной новости
        UIView.animate(withDuration: 0.3) { [weak self] in
            self?.transparentView.alpha = 0.5
            self?.view.alpha = 1
        }
        
        window.addSubview(transparentView)
        window.addSubview(self.view)
    }
    
    func removeBreakingNews() {
        UIView
            .animate(withDuration: 0.3,
                     animations:
        { [weak self] in
                self?.transparentView.alpha = 0
                self?.view.alpha = 0
        })
        { [weak self] _ in
            self?.transparentView.removeFromSuperview()
            self?.view.removeFromSuperview()
            if let check = self?.isDetailPresent, check {
                self?.isDetailPresent = false
            }
        }
    }
}

extension BreakingNewsViewController: BreakingNewsDelegate {
    func detailButtonHandler() {
        detailButtonViewController.presentController(parent: self)
    }
    
    func backButtonHandler() {
        self.removeBreakingNews()
    }
}
