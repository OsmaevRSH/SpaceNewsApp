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
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        navigationController?.show(BreakingVideoViewController(), sender: nil)
    }
}
