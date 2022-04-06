//
//  BreakingVideoViewController.swift
//  SpaceNewsApp
//
//  Created by Руслан Осмаев on 03.03.2022.
//

import UIKit


class BreakingVideoViewController: UIViewController {
    
    /// Нужно ли загружать следующую страницу с новостями
    var isFetchMoreNews: Bool = true
    
    let videoView = BreakingVideoView()

    var viewModel: VideosListViewModel!
    
    var videosListData: [VideoModel] = []
    
    var recomendedVideos: [VideoModel] = [] {
        didSet {
            videoView.recomendationTableView.reloadData()
        }
    }
    
    private var videoId: String = ""
    private var videoTitle: String = ""
    private var videoPublishedAt: String = ""
    
    override func loadView() {
        view = videoView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Video"
        videoView.recomendationTableView.delegate = self
        videoView.recomendationTableView.dataSource = self
        videoView.recomendationTableView.register(RecomendationVideoCell.self, forCellReuseIdentifier: RecomendationVideoCell.cellId)
        binding()
        setupBarButtonItems()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        recomendedVideos = videosListData.filter({ [weak self] item in
            item.videoId != self?.videoId
        })
        videoView.videoView.load(withVideoId: videoId)
        videoView.videoTitle.text = videoTitle
        videoView.videoPublishedAt.text = videoPublishedAt
    }
    
    private func setupBarButtonItems() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "arrowshape.turn.up.right"),
                                                            style: .done, target: self, action: #selector(shareButtonHandler))
    }
    
    func setupVideoInfo(videoId: String, videoTitle: String, videoPublishedAt: String) {
        self.videoId = videoId
        self.videoTitle = videoTitle
        self.videoPublishedAt = videoPublishedAt
    }
    
    func binding() {
        viewModel.$videosListData
            .assign(to: \.videosListData, on: self)
            .store(in: &CancellableSetService.set)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        videoView.recomendationTableView.contentOffset = CGPoint(x: 0, y: 0)
    }
    
    @objc private func shareButtonHandler() {
            let firstActivityItem = "Video: "

            let secondActivityItem : NSURL = NSURL(string: "https://m.youtube.com/watch?v=\(videoId)&feature=youtu.be")!
            
            let activityViewController : UIActivityViewController = UIActivityViewController(
                activityItems: [firstActivityItem, secondActivityItem], applicationActivities: nil)
            
            activityViewController.activityItemsConfiguration = [
            UIActivity.ActivityType.message
            ] as? UIActivityItemsConfigurationReading
            
            activityViewController.excludedActivityTypes = [
                UIActivity.ActivityType.postToWeibo,
                UIActivity.ActivityType.print,
                UIActivity.ActivityType.assignToContact,
                UIActivity.ActivityType.saveToCameraRoll,
                UIActivity.ActivityType.addToReadingList,
                UIActivity.ActivityType.postToFlickr,
                UIActivity.ActivityType.postToVimeo,
                UIActivity.ActivityType.postToTencentWeibo,
                UIActivity.ActivityType.postToFacebook
            ]
            
            activityViewController.isModalInPresentation = true
            self.present(activityViewController, animated: true, completion: nil)
    }
}
