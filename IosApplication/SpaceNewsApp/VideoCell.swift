//
//  VideoCell.swift
//  SpaceNewsApp
//
//  Created by Руслан Осмаев on 03.03.2022.
//

import UIKit

class VideoCell: UITableViewCell {

    /// Идентификатор кастомной ячейки
    static let reusableCellIdenifier = "VideoCell"
    
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
    
    /// View для отображения иконки канала
    lazy var chanelIcon: UIImageView = {
        var image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.cornerRadius = 22.5
        image.layer.masksToBounds = true
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFill
        image.image = UIImage(named: "Nasa")
        return image
    }()
    
    /// Stack view для тайтла и издатля новости
    lazy var infoStackView: UIStackView = {
        var stack = UIStackView(arrangedSubviews: [
            videoTitle, videoPublishedAt
        ])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 8.0
        return stack
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
        containerView.addSubview(infoStackView)
        containerView.addSubview(chanelIcon)
    }
    
    /// Метод для добавления констрентов для всех элементов ячейки
    private func addConstraints() {
        NSLayoutConstraint.activate([
            //containerView
            containerView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 8),
            containerView.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 16),
            containerView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            containerView.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor, constant: -16),
            //newsImage
            videoImage.widthAnchor.constraint(equalTo: videoImage.heightAnchor, multiplier: 16.0/9.0),
            videoImage.topAnchor.constraint(equalTo: containerView.safeAreaLayoutGuide.topAnchor),
            videoImage.leftAnchor.constraint(equalTo: containerView.safeAreaLayoutGuide.leftAnchor),
            videoImage.rightAnchor.constraint(equalTo: containerView.safeAreaLayoutGuide.rightAnchor),
            //chanelIcon
            chanelIcon.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 16),
            chanelIcon.widthAnchor.constraint(equalToConstant: 45),
            chanelIcon.heightAnchor.constraint(equalToConstant: 45),
            chanelIcon.centerYAnchor.constraint(equalTo: infoStackView.centerYAnchor),
            //infoStackView
            infoStackView.topAnchor.constraint(equalTo: videoImage.bottomAnchor, constant: 16),
            infoStackView.leftAnchor.constraint(equalTo: chanelIcon.rightAnchor, constant: 16),
            infoStackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -16),
            infoStackView.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -16)
        ])
    }

}
