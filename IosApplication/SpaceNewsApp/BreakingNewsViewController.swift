//
//  BreakingNewsViewController.swift
//  SpaceNewsApp
//
//  Created by Руслан Осмаев on 02.02.2022.
//

import UIKit

class BreakingNewsViewController: UIViewController {
	
	var breakingNewsView = BreakingNewsView()
	
	var newsURL: String!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
	
	convenience init(titleViewName: String, newsURL: String) {
		self.init(nibName: nil, bundle: nil)
		self.title = titleViewName
		self.newsURL = newsURL
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
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		if let url = URL(string: self.newsURL) {
			let request = URLRequest(url: url)
			breakingNewsView.webView.load(request)
		}
	}
}
