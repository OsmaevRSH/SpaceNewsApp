//
//  NewsViewControllerExtencion.swift
//  SpaceNewsApp
//
//  Created by Руслан Осмаев on 01.02.2022.
//

import Foundation
import UIKit

extension NewsViewController : UITableViewDelegate, UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return newsDataSet.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: newsView.cellId, for: indexPath) as? NewsTableViewCell
		if let cell = cell {
			cell.newsImage.image = UIImage(named: "TestNews")
			cell.newsInfo.text = newsDataSet[indexPath.row].title
			cell.newsPublishedAt.text = newsDataSet[indexPath.row].newsSite
			return cell
		}
		return UITableViewCell()
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		tableView.deselectRow(at: indexPath, animated: true)
		let item = newsDataSet[indexPath.row]
		if let title = item.title,
		   let url =  item.url
		{
			let breakingNewsView = BreakingNewsViewController(titleViewName: title, newsURL: url)
			navigationController?.show(breakingNewsView, sender: self)
		}
	}
}