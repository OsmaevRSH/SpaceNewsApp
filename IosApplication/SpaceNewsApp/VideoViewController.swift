//
//  VideoViewController.swift
//  SpaceNewsApp
//
//  Created by Руслан Осмаев on 25.02.2022.
//

import UIKit
import Combine

class VideoViewController: UIViewController {

    /// Происходит ли в данный момент обновления ленты видео
    var isRefresh: Bool = false
    
    /// Нужно ли загружать следующую страницу с новостями
    var isFetchMoreNews: Bool = true
    
    lazy var refreshController: UIRefreshControl = {
        var controller = UIRefreshControl()
        controller.attributedTitle = NSAttributedString(string: "Refresh videos")
        controller.addTarget(self, action: #selector(refreshHandeler), for: .valueChanged)
        return controller
    }()
    
    let VideosView = VideosListView()
    
    var breakingVideoViewController: BreakingVideoViewController!
    
    var viewModel: VideosListViewModel!
    
    var videosListData: [VideoModel] = [] {
        didSet {
            VideosView.videosTable.reloadData()
            if isRefresh {
                isRefresh = false
                refreshController.endRefreshing()
            }
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
        self.VideosView.videosTable.addSubview(refreshController)
    }
    
    override func loadView() {
        view = VideosView
    }
    
    func binding() {
        viewModel.$videosListData
            .assign(to: \.videosListData, on: self)
            .store(in: &CancellableSetService.set)
    }
    
    @objc private func refreshHandeler() {
        isRefresh = true
        self.viewModel.getVideosList(loadFirstPage: true)
    }
}
