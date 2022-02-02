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
		return dataSet.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? NewsTableViewCell
		if let cell = cell {
			cell.newsImage.image = UIImage(named: "TestNews")
			cell.newsInfo.text = dataSet[indexPath.row].title
			cell.newsPublishedAt.text = dataSet[indexPath.row].source
			return cell
		}
		return UITableViewCell()
	}
}
