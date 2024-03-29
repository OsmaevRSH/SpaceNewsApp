//
//  VideoViewControllerExtention.swift
//  SpaceNewsApp
//
//  Created by Руслан Осмаев on 03.03.2022.
//

import Foundation
import UIKit

extension VideoViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return videosListData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: VideoCell.reusableCellIdenifier, for: indexPath) as? VideoCell
        else {
            return VideoCell()
        }
        cell.videoImage.loadImage(from: videosListData[indexPath.row].imageUrl)
        cell.videoTitle.text = videosListData[indexPath.row].title
        cell.videoPublishedAt.text = videosListData[indexPath.row].chanelTitle
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = videosListData[indexPath.row]
        guard
            let videoId = item.videoId,
            let videoTitle = item.title,
            let videoPublishedAt = item.chanelTitle
        else {
                return
            }
        breakingVideoViewController.setupVideoInfo(videoId:  videoId, videoTitle: videoTitle, videoPublishedAt: videoPublishedAt)
        navigationController?.show(breakingVideoViewController, sender: nil)
    }
    
    /// Метод вызывается при прокрутке таблицы
    /// - Parameter scrollView: Текущий scrollView
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let position = scrollView.contentOffset.y
        let size = VideosView.videosTable.contentSize.height
        if position > size - scrollView.visibleSize.height && position > 0 {
            if isFetchMoreNews {
                isFetchMoreNews = false
                loadMoreNews()
            }
        }
    }
    
    /// Метод для подгрузки средующей страницы новостей
    private func loadMoreNews() {
        VideoHttpService.shared.getVideos(loadFirstPage: false)
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
                self?.videosListData.append(contentsOf: videos)
                self?.isFetchMoreNews = true
            }
            .store(in: &CancellableSetService.set)
    }
}
