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
	
	var newsDataSet: [NewsModel] = [NewsModel.placeholder] {
		didSet {
			newsView.newsTable.reloadData()
		}
	}

	var newsView = NewsView()
	
    override func viewDidLoad() {
        super.viewDidLoad()
		title = "News"
		newsView.newsTable.delegate = self
		newsView.newsTable.dataSource = self
		binding()
    }
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		viewModel.getNews()
	}
	
	override func loadView() {
		view = newsView
	}
	
	private func binding() {
		viewModel
			.$newsDataSet.assign(to: \.newsDataSet, on: self)
			.store(in: &self.cancelableSet)
	}
}
