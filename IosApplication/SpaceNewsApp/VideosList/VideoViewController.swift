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
    
    var isLiveVideo = true
    
    lazy var liveButton: UIButton = {
        var button = UIButton(type: .system)
        button.setTitle("Offline", for: .normal)
        button.backgroundColor = .systemGray4
        button.tintColor = .black
        button.frame.size = CGSize(width: 64, height: 26)
        button.layer.cornerRadius = 13
        button.addTarget(self, action: #selector(liveButtonHandler), for: .touchUpInside)
        return button
    }()
    
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
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: liveButton)
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
        if !isLiveVideo {
            viewModel.getLiveVideoList()
        }
        else {
            viewModel.getVideosList(loadFirstPage: true)
        }
    }
    
    @objc private func liveButtonHandler() {
        if !isLiveVideo {
            viewModel.getVideosList(loadFirstPage: true)
            liveButton.setTitle("Offline", for: .normal)
            liveButton.backgroundColor = .systemGray4
            liveButton.tintColor = .black
        }
        else {
            viewModel.getLiveVideoList()
            liveButton.setTitle("Live", for: .normal)
            liveButton.backgroundColor = .red
            liveButton.tintColor = .white
        }
        isLiveVideo = !isLiveVideo
    }
}
