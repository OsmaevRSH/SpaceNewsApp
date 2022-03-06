//
//  BreakingVideoView.swift
//  SpaceNewsApp
//
//  Created by Руслан Осмаев on 06.03.2022.
//

import UIKit
import youtube_ios_player_helper

class BreakingVideoView: UIView {
    
    /// View с видео
    lazy var videoView: YTPlayerView = {
        var view = YTPlayerView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    /// Иконка нканала
    lazy var icon: CustomUIImageView = {
        var view = CustomUIImageView()
        view.loadImage(from: NSURL(string: "https://s3-alpha-sig.figma.com/img/038e/1e38/52a01ca7ac25f3fae4e57f030adb0225?Expires=1647216000&Signature=IzC4z1i9OqQYuDM4E6YnoWEMaEv-ESGZvi4Ex8LrDP6MmpDFPB4u7MXHFzTFN5eZrKDfcUFNEevQXPUqSF-2sE4X1eW9yQp9sH3b~CdZku0g9aiHKdaZAVfJ4QKFGVqM5GfRTO0r8tSWCMEjRQ6N2t-i0ZUHhklIE4ysR1LRzvO3EghNlZdaPNIP5j3E8OEu2XZokhjQNc5yQJ-ZwcZpsvHA2U5hEzQ6jveEx0WjDhGoEw2Srd1OPGspVfkY57HAIVi4N6qoD1Rg024cEvPsnV4-S0QKSipw8sksjhBiDvlY7NoQPZAVeU18sQE7s3vfMK~9iEwRaPAtAx9WrgIxoA__&Key-Pair-Id=APKAINTVSUGEWH5XD5UA"))
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    /// Title для хранения заголовка видео
    lazy var videoTitle: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = UIFont(name: "SF Pro Text", size: 15)
        label.font = .systemFont(ofSize: 15, weight: .semibold)
        return label
    }()
    
    /// Title для хранения названия канала
    lazy var videoPublishedAt: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "SF Pro Text", size: 13)
        label.font = .systemFont(ofSize: 13, weight: .regular)
        return label
    }()
    
    /// Stack для хранения названия видео и названия канала
    lazy var infoStackView: UIStackView = {
        var stack = UIStackView(arrangedSubviews: [
            videoTitle, videoPublishedAt
        ])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 8.0
        return stack
    }()
    
    /// Таблица для представления рекомендация под видео
    lazy var recomendationTableView: UITableView = {
        var table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.separatorStyle = .none
        table.backgroundColor = Colors.tableViewBackground.color
        return table
    }()
    
    /// Метод для установки констрейнтов
    private func addConstraints() {
        NSLayoutConstraint.activate([
            videoView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            videoView.leftAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leftAnchor),
            videoView.rightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.rightAnchor),
            videoView.widthAnchor.constraint(equalTo: videoView.heightAnchor, multiplier: 16.0/9.0),
            //chanelIcon
            icon.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 16),
            icon.widthAnchor.constraint(equalToConstant: 45),
            icon.heightAnchor.constraint(equalToConstant: 45),
            icon.centerYAnchor.constraint(equalTo: infoStackView.centerYAnchor),
            //infoStackView
            infoStackView.topAnchor.constraint(equalTo: videoView.bottomAnchor, constant: 16),
            infoStackView.leftAnchor.constraint(equalTo: icon.rightAnchor, constant: 16),
            infoStackView.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor, constant: -16),
            //recomendationTableView
            recomendationTableView.topAnchor.constraint(equalTo: infoStackView.bottomAnchor, constant: 16),
            recomendationTableView.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor),
            recomendationTableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            recomendationTableView.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor)
        ])
    }
    
    /// Конструктор
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(videoView)
        addSubview(infoStackView)
        addSubview(icon)
        addSubview(recomendationTableView)
        addConstraints()
        self.backgroundColor = Colors.tableViewBackground.color
    }
    
    /// Не используемый конструктор
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
