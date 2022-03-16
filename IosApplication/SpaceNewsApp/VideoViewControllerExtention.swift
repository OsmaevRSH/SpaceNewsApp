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
            let cell = tableView.dequeueReusableCell(withIdentifier: VideosView.cellId, for: indexPath) as? VideoCell
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
}
