//
//  NewsViewController.swift
//  SpaceNewsApp
//
//  Created by Руслан Осмаев on 01.02.2022.
//

import UIKit

class NewsViewController: UIViewController {

	var newsView = NewsView()
	
    override func viewDidLoad() {
        super.viewDidLoad()
		title = "News"
    }
	
	override func loadView() {
		view = newsView
	}
}
