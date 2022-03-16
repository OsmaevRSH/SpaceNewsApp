//
//  BreakingVideoViewControllerExtention.swift
//  SpaceNewsApp
//
//  Created by Руслан Осмаев on 06.03.2022.
//

import Foundation
import UIKit

extension BreakingVideoViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        recomendedVideos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: RecomendationVideoCell.cellId, for: indexPath) as? RecomendationVideoCell
        else {
            return RecomendationVideoCell()
        }
        
        let item = recomendedVideos[indexPath.row]
        
        cell.videoImage.loadImage(from: item.imageUrl)
        cell.videoTitle.text = item.title
        cell.videoChanellTitle.text = item.chanelTitle
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let newItem = recomendedVideos[indexPath.row]
        guard
            let id = newItem.videoId,
            let title = newItem.title,
            let publishedAt = newItem.chanelTitle
        else {
            return
        }
        videoView.videoView.load(withVideoId: id)
        videoView.videoTitle.text = title
        videoView.videoPublishedAt.text = publishedAt
        recomendedVideos = videosListData.filter({ item in
            item.videoId != id
        })
        guard let newIndexPath = videoView.recomendationTableView.indexPathForRow(at: CGPoint(x: 0, y: 0)) else { return }
        videoView.recomendationTableView.scrollToRow(at: newIndexPath, at: .none, animated: true)
    }
    
    /// Метод вызывается при прокрутке таблицы
    /// - Parameter scrollView: Текущий scrollView
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let position = scrollView.contentOffset.y
        let size = videoView.recomendationTableView.contentSize.height
        if position > size - scrollView.visibleSize.height && position > 0 {
            if isFetchMoreNews {
                isFetchMoreNews = false
                loadMoreNews()
            }
        }
    }
    
    /// Метод для подгрузки средующей страницы новостей
    private func loadMoreNews() {
        VideoHttpService.shared.getAListOfVideos(loadFirstPage: false)
            .map {
                $0.map {
                    VideoModel(
                        imageUrl: NSURL(string: $0.snippet?.thumbnails?.high?.url ?? ""),
                        title: $0.snippet?.title,
                        videoId: $0.id?.videoID,
                        chanelTitle: $0.snippet?.channelTitle)
                }
            }
            .sink { [weak self] videos in
                self?.recomendedVideos.append(contentsOf: videos)
                self?.isFetchMoreNews = true
            }
            .store(in: &CancellableSetService.set)
    }
}
