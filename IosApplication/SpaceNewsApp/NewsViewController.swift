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
    
    /// View для затемнения заднего фона при открытии определенной новости
    lazy var transparentView: UIView = {
        var localView = UIView()
        localView.frame = view.frame
        return localView
    }()
    
    /// Метод для добавления затемняющего view и показа конкретной новости
    func showTransparentView() {
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
        breakingNewsViewController.view.frame = CGRect(x: window.safeAreaLayoutGuide.layoutFrame.origin.x + 16,
                                         y: window.safeAreaLayoutGuide.layoutFrame.origin.y + 16,
                                         width: window.safeAreaLayoutGuide.layoutFrame.width - 32,
                                         height: newsViewHeight)
        
        breakingNewsViewController.view.alpha = 0
        
        /// Задаем параметры для затемняющего view
        transparentView.frame = window.frame
        transparentView.backgroundColor = .black.withAlphaComponent(0.9)
        transparentView.alpha = 0

        /// Устновка параметров анимации появления конкретной новости
        UIView.animate(withDuration: 0.3) { [weak self] in
            self?.transparentView.alpha = 0.5
            self?.breakingNewsViewController.view.alpha = 1
        }
        
        window.addSubview(transparentView)
        window.addSubview(breakingNewsViewController.view)
    }
    
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
    @objc func refreshHandeler() {
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
                                                           style: .done, target: self, action: #selector(favoriteButtonHandler))
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
    
    @objc private func favoriteButtonHandler() {
        navigationController?.show(favoriteNewsViewController, sender: nil)
    }
}
