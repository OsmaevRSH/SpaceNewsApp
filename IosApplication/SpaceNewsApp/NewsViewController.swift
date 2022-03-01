//
//  NewsViewController.swift
//  SpaceNewsApp
//
//  Created by Руслан Осмаев on 01.02.2022.
//

import UIKit
import Combine

class NewsViewController: UIViewController {
    
    lazy var transparentView: UIView = {
        var localView = UIView()
        localView.frame = view.frame
        var tap = UITapGestureRecognizer(target: self, action: #selector(removeTransparentView))
        localView.addGestureRecognizer(tap)
        return localView
    }()
    
    @objc private func removeTransparentView() {
        UIView
            .animate(withDuration: 0.3,
                     animations:
        { [weak self] in
           self?.transparentView.alpha = 0
           self?.breakingNewsViewController.view.alpha = 0
        })
        { [weak self] _ in
            self?.transparentView.removeFromSuperview()
            self?.breakingNewsViewController.view.removeFromSuperview()
        }
    }
    
    func showTransparentView() {
        let window = UIApplication.shared.connectedScenes
            .flatMap{ ($0 as? UIWindowScene)?.windows ?? [] }
            .first{ $0.isKeyWindow }
        
        guard let window = window else {
            return
        }
        
        let newsViewHeight = window.safeAreaLayoutGuide.layoutFrame.height - 32
        
        breakingNewsViewController.view.frame = CGRect(x: window.safeAreaLayoutGuide.layoutFrame.origin.x + 16,
                                         y: window.safeAreaLayoutGuide.layoutFrame.origin.y + 16,
                                         width: window.safeAreaLayoutGuide.layoutFrame.width - 32,
                                         height: newsViewHeight)
        breakingNewsViewController.view.alpha = 0
        
        transparentView.frame = window.frame
        transparentView.backgroundColor = .black.withAlphaComponent(0.9)
        transparentView.alpha = 0

        UIView.animate(withDuration: 0.3) { [weak self] in
            self?.transparentView.alpha = 0.5
            self?.breakingNewsViewController.view.alpha = 1
        }
        window.addSubview(transparentView)
        window.addSubview(breakingNewsViewController.view)
    }
    
    var viewModel: NewsViewModel!
    var breakingNewsViewController: BreakingNewsViewController!
    
    var newsTableView = NewsTableView()
    var isFetchMoreNews: Bool = true
    var isRefresh: Bool = false
    
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
    
    lazy var refreshItem: UIRefreshControl = {
        var refresh = UIRefreshControl()
        refresh.attributedTitle = NSAttributedString(string: "Refresh news")
        refresh.addTarget(self, action: #selector(refreshHandeler), for: .valueChanged)
        return refresh
    }()
    
    @objc func refreshHandeler() {
        isRefresh = true
        self.viewModel.getNews(newsOffset: 0)
    }
    
    var dataSource: UITableViewDiffableDataSource<Section, NewsCellModel>! = nil
	
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.getNews(newsOffset: 0)
		title = "News"
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "tray.full"),
                                                           style: .done, target: nil, action: nil)
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "person.wave.2"),
                                                           style: .done, target: nil, action: nil)
        setupDataSource()
        binding()
        newsTableView.newsTable.addSubview(refreshItem)
        newsTableView.newsTable.delegate = self
    }
    
    private func setupFontTitleStyle() {
        let attributes = [NSAttributedString.Key.font: UIFont(name: "SF Pro Text", size: 17),
                          NSAttributedString.Key.font: .systemFont(ofSize: 17, weight: .semibold)]
        UINavigationBar.appearance().titleTextAttributes = attributes as [NSAttributedString.Key : Any]
    }

	override func loadView() {
		view = newsTableView
	}
	
	private func binding() {
		viewModel
			.$newsDataSet.assign(to: \.newsDataSet, on: self)
            .store(in: &CancellableSetService.shared.set)
	}
    
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
