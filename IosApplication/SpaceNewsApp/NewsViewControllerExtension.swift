//
//  NewsViewControllerExtencion.swift
//  SpaceNewsApp
//
//  Created by Руслан Осмаев on 01.02.2022.
//

import Foundation
import UIKit

extension NewsViewController : UITableViewDelegate {
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		tableView.deselectRow(at: indexPath, animated: true)
		let item = newsDataSet[indexPath.row]
        if let newsUrl =  item.newsUrl as URL?,
           let title = item.title,
           let imageUrl = item.imageUrl as URL?
		{
            breakingNewsViewController.setupFields(titleViewName: title,
                                         newsURL: newsUrl,
                                         imageURL: imageUrl,
                                         newsId: item.newsId)
            navigationController?.show(breakingNewsViewController, sender: nil)
		}
	}
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let position = scrollView.contentOffset.y
        let size = newsTableView.newsTable.contentSize.height
        if position > size - scrollView.visibleSize.height && position > 0 {
            if isFetchMoreNews {
                isFetchMoreNews = false
                loadMoreNews()
            }
        }
    }
    
    private func loadMoreNews() {
        APIServiceImplementation.shared.getNews(newsOffset: (newsDataSet.count / 20) * 20 + 1)
        .sink { [weak self] news in
            let data = news.map {
                NewsCellModel(imageUrl: NSURL(string: $0.imageURL ?? ""),
                              title: $0.title,
                              publishedAt: $0.newsSite,
                              newsUrl: NSURL(string: $0.url ?? ""),
                              newsId: $0.id ?? 0
                              )
            }
            self?.newsDataSet.append(contentsOf: data)
            self?.isFetchMoreNews = true
        }
        .store(in: &CancellableSetService.shared.set)
    }
}
