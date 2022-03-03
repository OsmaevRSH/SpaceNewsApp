//
//  BreakingVideoViewController.swift
//  SpaceNewsApp
//
//  Created by Руслан Осмаев on 03.03.2022.
//

import UIKit
import youtube_ios_player_helper

class BreakingVideoViewController: UIViewController {

    lazy var videoView: YTPlayerView = {
        var view = YTPlayerView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Video"
        view.addSubview(videoView)
        addConstraints()
        videoView.load(withVideoId: "YE7VzlLtp-4", playerVars: ["playsinline": "1"])
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            videoView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            videoView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            videoView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            videoView.widthAnchor.constraint(equalTo: videoView.heightAnchor, multiplier: 16.0/9.0)
        ])
    }
}
