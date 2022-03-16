//
//  NewsViewController.swift
//  SpaceNewsApp
//
//  Created by Руслан Осмаев on 01.02.2022.
//

import UIKit
import Combine

class NewsViewController: UIViewController {
    
    /// ViewModel таблицы новостей
    var viewModel: NewsViewModel!
    
    /// ViewModel конкретной новости
    var breakingNewsViewController: BreakingNewsViewController!
    
    /// ViewController избранных новостей
    var favoriteNewsViewController: FavoriteNewsViewController!
    
    /// View таблицы
    var newsTableView = NewsTableView()
    
    /// Нужно ли загружать следующую страницу с новостями
    var isFetchMoreNews: Bool = true
    
    /// Происходит ли в данный момент обновления ленты новостей
    var isRefresh: Bool = false
    
    /// Переменная для хранения новостей
    var newsDataSet: [NewsModel] = [] {
        didSet {
            newsTableView.newsTable.reloadData()
            if isRefresh {
                isRefresh = false
                refreshItem.endRefreshing()
            }
        }
    }
    
    /// Refresh controller
    lazy var refreshItem: UIRefreshControl = {
        var refresh = UIRefreshControl()
        refresh.attributedTitle = NSAttributedString(string: "Refresh news")
        refresh.addTarget(self, action: #selector(refreshHandeler), for: .valueChanged)
        return refresh
    }()
    
    /// Обработчик взаимодействия с refresh controller
    @objc private func refreshHandeler() {
        isRefresh = true
        self.viewModel.getNews(newsOffset: 0)
    }
	
    /// View did load
    override func viewDidLoad() {
        super.viewDidLoad()
        newsTableView.newsTable.addSubview(refreshItem)
        newsTableView.newsTable.delegate = self
        newsTableView.newsTable.dataSource = self
        binding()
        viewModel.getNews(newsOffset: 0)
        setupTitleStyle()
        setupBarButtonItem()
    }
    
    /// Load view для устновки своей view
    override func loadView() {
        view = newsTableView
    }
    
    /// Метод для добавдения кнопок в Navigation Bar
    private func setupBarButtonItem() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "tray.full"),
                                                           style: .done, target: self, action: #selector(readingListButtonHandler))
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "person.wave.2"),
                                                           style: .done, target: nil, action: nil)
    }
    
    /// Метод для установки стиля текста Title в Navigation Bar
    private func setupTitleStyle() {
        title = "News"
        let attributes = [NSAttributedString.Key.font: UIFont(name: "SF Pro Text", size: 17)]
        UINavigationBar.appearance().titleTextAttributes = attributes as [NSAttributedString.Key : Any]
    }
    
    /// Метод для биндина полей к viewModel
	private func binding() {
		viewModel
			.$newsDataSet.assign(to: \.newsDataSet, on: self)
            .store(in: &CancellableSetService.set)
	}
    
    @objc private func readingListButtonHandler() {
        navigationController?.show(favoriteNewsViewController, sender: nil)
    }
}
