//
//  NewsViewControllerExtencion.swift
//  SpaceNewsApp
//
//  Created by Руслан Осмаев on 01.02.2022.
//

import Foundation
import UIKit

extension NewsViewController : UITableViewDelegate, UITableViewDataSource, BreakingNewsDelegate {    
    // MARK: - UITableViewDelegate
    
    /// Метод вызывающийся при нажатии на ячейку таблицы
    /// - Parameters:
    ///   - tableView: Текущая таблицы
    ///   - indexPath: Index path нажатой ячейки
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
            breakingNewsViewController.showBreakingNews()
		}
	}
    
    /// Метод вызывается при прокрутке таблицы
    /// - Parameter scrollView: Текущий scrollView
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
    
    /// Метод для подгрузки средующей страницы новостей
    private func loadMoreNews() {
        NewsHttpService.shared.getNews(newsOffset: (newsDataSet.count / 20) * 20 + 1)
        .sink { [weak self] news in
            let data = news.map {
                NewsModel(imageUrl: NSURL(string: $0.imageURL ?? ""),
                              title: $0.title,
                              publishedAt: $0.newsSite,
                              newsUrl: NSURL(string: $0.url ?? ""),
                              newsId: $0.id ?? 0
                              )
            }
            self?.newsDataSet.append(contentsOf: data)
            self?.isFetchMoreNews = true
        }
        .store(in: &CancellableSetService.set)
    }
    
    /// Метод возвращающий кол-во элементов в секции
    /// - Parameters:
    ///   - tableView: Текущая таблица
    ///   - section: Текущая секция
    /// - Returns: Кол-во элементов в секции
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsDataSet.count
    }
    
    /// Метод для отобрадения новой ячейки
    /// - Parameters:
    ///   - tableView: Текущая таблица
    ///   - indexPath: Index path текущей ячейки
    /// - Returns: Модифицированная ячейка
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: NewsTableViewCell.reusableCellIdenifier, for: indexPath) as? NewsTableViewCell
        else {
            return NewsTableViewCell()
        }
        let item = newsDataSet[indexPath.row]
        cell.newsTitle.text = item.title
        cell.newsImage.loadImage(from: item.imageUrl)
        cell.newsPublishedAt.text = item.publishedAt
        return cell
    }
    
    // MARK: - BreakingNewsDelegate
    
    /// Метод обработки закрытия конкретной новости
    @objc func backButtonHandler() {
        ///Настройка параметров анимации для скрытия новости
        breakingNewsViewController.removeBreakingNews()
    }
}
