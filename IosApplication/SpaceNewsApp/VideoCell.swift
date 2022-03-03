//
//  VideoCell.swift
//  SpaceNewsApp
//
//  Created by Руслан Осмаев on 03.03.2022.
//

import UIKit

class VideoCell: UITableViewCell {

    /// View для отображения превью видео
    lazy var videoImage: CustomUIImageView = {
        var image = CustomUIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        image.layer.cornerRadius = 22
        image.layer.masksToBounds = true
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    /// View для обображения Title новости
    lazy var videoTitle: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "SF Pro Text", size: 15)
        label.font = .systemFont(ofSize: 15, weight: .semibold)
        label.numberOfLines = 0
        return label
    }()
    
    /// View для отображения, кем была опубликована новость
    lazy var videoPublishedAt: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "SF Pro Text", size: 13)
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 13, weight: .regular)
        return label
    }()
    
    /// View контейнер для хранения элементов ячейки
    lazy var containerView: UIView = {
        var view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 22
        view.backgroundColor = .systemBackground
        return view
    }()
    
    /// Конструктор ячейки
    /// - Parameters:
    ///   - style: Стиль ячейки
    ///   - reuseIdentifier: Идентификатор ячейки для переиспользования
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubviews()
        addConstraints()
        self.selectionStyle = .none
    }
    
    /// Не используемый конструктор
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// Метод для добавления всех Subviews
    private func addSubviews() {
        self.backgroundColor = Colors.tableViewBackground.color
        addSubview(containerView)
        containerView.addSubview(videoImage)
        containerView.addSubview(videoTitle)
        containerView.addSubview(videoPublishedAt)
    }
    
    /// Метод для добавления констрентов для всех элементов ячейки
    private func addConstraints() {
        NSLayoutConstraint.activate([
            //containerView
            containerView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 4),
            containerView.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 16),
            containerView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -4),
            containerView.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor, constant: -16),
            //newsImage
            videoImage.heightAnchor.constraint(equalToConstant: 240),
            videoImage.topAnchor.constraint(equalTo: containerView.safeAreaLayoutGuide.topAnchor),
            videoImage.leftAnchor.constraint(equalTo: containerView.safeAreaLayoutGuide.leftAnchor),
            videoImage.rightAnchor.constraint(equalTo: containerView.safeAreaLayoutGuide.rightAnchor),
            //newsTitle
            videoTitle.topAnchor.constraint(equalTo: videoImage.safeAreaLayoutGuide.bottomAnchor, constant: 16),
            videoTitle.leftAnchor.constraint(equalTo: containerView.safeAreaLayoutGuide.leftAnchor, constant: 16),
            videoTitle.rightAnchor.constraint(equalTo: containerView.safeAreaLayoutGuide.rightAnchor, constant: -16),
            //newsPublishedAt
            videoPublishedAt.heightAnchor.constraint(equalToConstant: 25),
            videoPublishedAt.topAnchor.constraint(equalTo: videoTitle.safeAreaLayoutGuide.bottomAnchor),
            videoPublishedAt.leftAnchor.constraint(equalTo: containerView.safeAreaLayoutGuide.leftAnchor, constant: 16),
            videoPublishedAt.rightAnchor.constraint(equalTo: containerView.safeAreaLayoutGuide.rightAnchor, constant: -16),
            videoPublishedAt.bottomAnchor.constraint(equalTo: containerView.safeAreaLayoutGuide.bottomAnchor, constant: -16)
        ])
    }

}
