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
        cell.chanelIcon.loadImage(from: NSURL(string: "https://s3-alpha-sig.figma.com/img/038e/1e38/52a01ca7ac25f3fae4e57f030adb0225?Expires=1647216000&Signature=IzC4z1i9OqQYuDM4E6YnoWEMaEv-ESGZvi4Ex8LrDP6MmpDFPB4u7MXHFzTFN5eZrKDfcUFNEevQXPUqSF-2sE4X1eW9yQp9sH3b~CdZku0g9aiHKdaZAVfJ4QKFGVqM5GfRTO0r8tSWCMEjRQ6N2t-i0ZUHhklIE4ysR1LRzvO3EghNlZdaPNIP5j3E8OEu2XZokhjQNc5yQJ-ZwcZpsvHA2U5hEzQ6jveEx0WjDhGoEw2Srd1OPGspVfkY57HAIVi4N6qoD1Rg024cEvPsnV4-S0QKSipw8sksjhBiDvlY7NoQPZAVeU18sQE7s3vfMK~9iEwRaPAtAx9WrgIxoA__&Key-Pair-Id=APKAINTVSUGEWH5XD5UA"))
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
