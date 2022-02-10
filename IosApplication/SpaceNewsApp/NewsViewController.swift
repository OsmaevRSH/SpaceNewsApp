//
//  NewsViewController.swift
//  SpaceNewsApp
//
//  Created by Руслан Осмаев on 01.02.2022.
//

import UIKit
import Combine

class NewsViewController: UIViewController {
	
	private var cancelableSet: Set<AnyCancellable> = []
	private let viewModel = NewsViewModel()
    private var newsTableView = NewsTableView()
    
    var newsDataSet: [NewsCellModel] = [] {
        didSet {
            var initialSnapshot = NSDiffableDataSourceSnapshot<Section, NewsCellModel>()
            initialSnapshot.appendSections([.main])
            initialSnapshot.appendItems(newsDataSet)
            self.dataSource.apply(initialSnapshot, animatingDifferences: true)
        }
    }
    
    var dataSource: UITableViewDiffableDataSource<Section, NewsCellModel>! = nil
	
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.getNews()
		title = "News"
        setupDataSource()
        binding()
        newsTableView.newsTable.delegate = self
    }

	override func loadView() {
		view = newsTableView
	}
	
	private func binding() {
		viewModel
			.$newsDataSet.assign(to: \.newsDataSet, on: self)
			.store(in: &self.cancelableSet)
	}
    
    private func setupDataSource() {
        dataSource = UITableViewDiffableDataSource<Section, NewsCellModel>(tableView: newsTableView.newsTable) {
            (tableView: UITableView, indexPath: IndexPath, fetchedItem: NewsCellModel) -> UITableViewCell? in
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath) as? NewsTableViewCell else { return NewsTableViewCell() }
            
            cell.newsInfo.text = fetchedItem.title
            cell.newsPublishedAt.text = fetchedItem.publishedAt
            cell.newsImage.image = fetchedItem.image
            
            guard let imageUrl = fetchedItem.imageUrl else { return NewsTableViewCell() }
            ImageCache.shared.loadImage(url: imageUrl, fetchedItem: fetchedItem) { (fetchedItem, image) in
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
