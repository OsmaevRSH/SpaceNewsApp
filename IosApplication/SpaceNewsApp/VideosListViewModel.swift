//
//  VideosListViewModel.swift
//  SpaceNewsApp
//
//  Created by Руслан Осмаев on 27.02.2022.
//

import Combine
import Foundation

class VideosListViewModel {
    
    @Published var videosListData: [VideoCellModel] = []
    
    func getVideosList() {
        APIServiceImplementation.shared.getAListOfVideos()
            .map {
                $0.map {
                    VideoCellModel(
                        imageUrl: NSURL(string: $0.snippet?.thumbnails?.high?.url ?? ""),
                        title: $0.snippet?.title,
                        videoId: $0.id?.videoID)
                }
            }
            .assign(to: \.videosListData, on: self)
            .store(in: &CancellableSetService.set)
    }
}
