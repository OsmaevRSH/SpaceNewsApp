//
//  NewsViewController.swift
//  SpaceNewsApp
//
//  Created by Руслан Осмаев on 01.02.2022.
//

import UIKit
import Combine

class NewsViewController: UIViewController {
    
    var viewModel: NewsViewModel!
    var breakingNewsViewController: BreakingNewsViewController!
    var newsTableView = NewsTableView()
    var isFetchMoreNews: Bool = true
    var isRefresh: Bool = false
    
    // MARK: - View для затемнения заднего фона при открытии определенной новости
    lazy var transparentView: UIView = {
        var localView = UIView()
        localView.frame = view.frame
        return localView
    }()
    
    // MARK: - Метод для добавления затемняющего view и показа конкретной новости
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
    
    // MARK: - Переменная для хранения новостей
    var newsDataSet: [NewsCellModel] = [] {
        didSet {
            var initialSnapshot = NSDiffableDataSourceSnapshot<Section, NewsCellModel>()
            initialSnapshot.appendSections([.main])
            initialSnapshot.appendItems(newsDataSet)
            self.dataSource.apply(initialSnapshot, animatingDifferences: false)
            if isRefresh {
                isRefresh = false
                refreshItem.endRefreshing()
            }
        }
    }
    
    // MARK: - Refresh controller
    lazy var refreshItem: UIRefreshControl = {
        var refresh = UIRefreshControl()
        refresh.attributedTitle = NSAttributedString(string: "Refresh news")
        refresh.addTarget(self, action: #selector(refreshHandeler), for: .valueChanged)
        return refresh
    }()
    
    // MARK: - Обработчик refresh controller
    @objc func refreshHandeler() {
        isRefresh = true
        self.viewModel.getNews(newsOffset: 0)
    }
    
    var dataSource: UITableViewDiffableDataSource<Section, NewsCellModel>! = nil
	
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.getNews(newsOffset: 0)
        setupTitleStyle()
        setupBarButtonItem()
        setupDataSource()
        binding()
        newsTableView.newsTable.addSubview(refreshItem)
        newsTableView.newsTable.delegate = self
    }
    
    override func loadView() {
        view = newsTableView
    }
    
    //MARK: - Метод настройки BarButtonItems
    private func setupBarButtonItem() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "tray.full"),
                                                           style: .done, target: nil, action: nil)
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "person.wave.2"),
                                                           style: .done, target: nil, action: nil)
    }
    
    //MARK: - Метод для установки стиля текста Title
    private func setupTitleStyle() {
        title = "News"
        let attributes = [NSAttributedString.Key.font: UIFont(name: "SF Pro Text", size: 17)]
        UINavigationBar.appearance().titleTextAttributes = attributes as [NSAttributedString.Key : Any]
    }

    //MARK: - Метод для биндина полей к viewModel
	private func binding() {
		viewModel
			.$newsDataSet.assign(to: \.newsDataSet, on: self)
            .store(in: &CancellableSetService.shared.set)
	}
    
    //MARK: - Метод для установки DataSource
    private func setupDataSource() {
        dataSource = UITableViewDiffableDataSource<Section, NewsCellModel>(tableView: newsTableView.newsTable) {
            (tableView: UITableView, indexPath: IndexPath, fetchedItem: NewsCellModel) -> UITableViewCell? in
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath) as? NewsTableViewCell else { return NewsTableViewCell() }
            
            cell.newsInfo.text = fetchedItem.title
            cell.newsPublishedAt.text = fetchedItem.publishedAt
            cell.newsImage.image = fetchedItem.image
            
            guard let imageUrl = fetchedItem.imageUrl else { return NewsTableViewCell() }
            ImageCache.shared.loadImageForTableView(url: imageUrl, fetchedItem: fetchedItem) { (fetchedItem, image) in
                if let img = image, img != fetchedItem.image {
                    var updatedSnapshot = self.dataSource.snapshot()
                    if let datasourceIndex = updatedSnapshot.indexOfItem(fetchedItem) {
                        let currentCell = self.newsDataSet[datasourceIndex]
                        currentCell.image = img
                        updatedSnapshot.reloadItems([currentCell])
                        self.dataSource.apply(updatedSnapshot, animatingDifferences: true)
                    }
                }
            }
            return cell
        }
    }
}
