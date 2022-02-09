//
//  NewsViewControllerExtencion.swift
//  SpaceNewsApp
//
//  Created by Руслан Осмаев on 01.02.2022.
//

import Foundation
import UIKit
import SafariServices

extension NewsViewController : UITableViewDelegate {
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		tableView.deselectRow(at: indexPath, animated: true)
		let item = newsDataSet[indexPath.row]
        if let url =  item.newsUrl as URL?
		{
            let breakingNewsView = SFSafariViewController(url: url)
			present(breakingNewsView, animated: true)
		}
	}
}
