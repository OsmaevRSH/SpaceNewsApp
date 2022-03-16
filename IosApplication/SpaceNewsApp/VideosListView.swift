//
//  VideosListView.swift
//  SpaceNewsApp
//
//  Created by Руслан Осмаев on 27.02.2022.
//

import UIKit

class VideosListView: UIView {

    /// Таблица для представления списка видео
    lazy var videosTable: UITableView = {
        var table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.register(VideoCell.self, forCellReuseIdentifier: VideoCell.reusableCellIdenifier)
        table.rowHeight = UITableView.automaticDimension
        table.estimatedRowHeight =  600
        table.separatorStyle = .none
        return table
    }()
    
    /// Метод для добавления констрейнтов
    private func addConstraints() {
        NSLayoutConstraint.activate([
            videosTable.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            videosTable.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor),
            videosTable.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            videosTable.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor)
        ])
    }
    
    /// Конструктор
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(videosTable)
        addConstraints()
    }
    
    /// Не используемый конструктор
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
