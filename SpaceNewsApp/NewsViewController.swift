//
//  NewsViewController.swift
//  SpaceNewsApp
//
//  Created by Руслан Осмаев on 01.02.2022.
//

import UIKit

struct data {
	var title: String
	var url: String
	var source: String
}

class NewsViewController: UIViewController {
	
	// MARK: - TestData
	let dataSet = [
		data(title: "Australian scientists discover ‘spooky’ object beaming out from space that flashes on and off",
			 url:"https://www.theguardian.com/australia-news/2022/jan/27/australian-scientists-discover-spooky-object-beaming-out-from-space-that-flashes-on-and-off",
			 source: "guardian"),
		data(title: "James Webb space telescope takes up station a million miles from Earth",
			 url:"https://www.theguardian.com/science/2022/jan/24/james-webb-space-telescope-station-a-million-miles-from-earth",
			 source: "guardian"),
		data(title: "Film studio in space planned for 2024",
			 url:"https://www.theguardian.com/film/2022/jan/20/film-studio-in-space-planned-for-2024",
			 source: "guardian"),
		data(title: "Nasa begins months-long effort to focus James Webb space telescope ",
			 url:"https://www.theguardian.com/science/2022/jan/13/nasa-begin-months-long-effort-to-bring-james-webb-space-telescope-into-focus",
			 source: "guardian"),
		data(title: "Nasa engineers complete the unfolding of the James Webb space telescope",
			 url:"https://www.theguardian.com/science/2022/jan/08/nasa-engineers-complete-the-unfolding-of-the-james-webb-space-telescope",
			 source: "guardian"),
		data(title: "To the moon and beyond: what 2022 holds for space travel",
			 url:"https://www.theguardian.com/science/2022/jan/02/to-the-moon-and-beyond-what-2022-holds-for-space-travel",
			 source: "guardian"),
		data(title: "Elon Musk rejects mounting criticism his satellites are clogging space",
			 url:"https://www.theguardian.com/technology/2021/dec/30/elon-musk-rejects-mounting-criticism-his-satellites-are-clogging-space",
			 source: "guardian"),
		data(title: " James Webb space telescope ",
			 url:"https://www.theguardian.com/science/james-webb-space-telescope",
			 source: "guardian")
	]
	
	// MARK: - EndTest

	var newsView = NewsView()
	
    override func viewDidLoad() {
        super.viewDidLoad()
		title = "News"
		newsView.newsTable.delegate = self
		newsView.newsTable.dataSource = self
		let newsCell = UINib(nibName: "NewsCell",
								  bundle: nil)
		newsView.newsTable.register(newsCell, forCellReuseIdentifier: "Cell")
		newsView.newsTable.rowHeight =  UITableView .automaticDimension
		newsView.newsTable.estimatedRowHeight =  600
    }
	
	override func loadView() {
		view = newsView
	}
}
