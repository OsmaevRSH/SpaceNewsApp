//
//  VideoViewController.swift
//  SpaceNewsApp
//
//  Created by Руслан Осмаев on 25.02.2022.
//

import UIKit
import Combine

class VideoViewController: UIViewController {

    let VideosView = VideosListView()
    
    var breakingVideoViewController: BreakingVideoViewController!
    
    var viewModel: VideosListViewModel!
    
    var videosListData: [VideoModel] = []
    {
        didSet {
            VideosView.videosTable.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Video"
        self.view.backgroundColor = .gray
        viewModel.getVideosList()
        binding()
        VideosView.videosTable.delegate = self
        VideosView.videosTable.dataSource = self
    }
    
    override func loadView() {
        view = VideosView
    }
    
    func binding() {
        viewModel.$videosListData
            .assign(to: \.videosListData, on: self)
            .store(in: &CancellableSetService.set)
    }
}
