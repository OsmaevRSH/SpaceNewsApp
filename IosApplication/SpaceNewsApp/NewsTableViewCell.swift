//
//  NewsTableViewCell.swift
//  SpaceNewsApp
//
//  Created by Руслан Осмаев on 02.02.2022.
//

import UIKit

class NewsTableViewCell: UITableViewCell {
    
    /// Идентификатор кастомной ячейки
    static let reusableCellIdenifier = "NewsTableViewCell"
		
    /// View для отображения картинки новости
    lazy var newsImage: CustomUIImageView = {
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
    lazy var newsTitle: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "SF Pro Text", size: 15)
        label.font = .systemFont(ofSize: 15, weight: .semibold)
        label.numberOfLines = 0
        return label
    }()
    
    /// View для отображения, кем была опубликована новость
    lazy var newsPublishedAt: UILabel = {
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
        containerView.addSubview(newsImage)
        containerView.addSubview(newsTitle)
        containerView.addSubview(newsPublishedAt)
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
            newsImage.heightAnchor.constraint(equalToConstant: 240),
            newsImage.topAnchor.constraint(equalTo: containerView.safeAreaLayoutGuide.topAnchor),
            newsImage.leftAnchor.constraint(equalTo: containerView.safeAreaLayoutGuide.leftAnchor),
            newsImage.rightAnchor.constraint(equalTo: containerView.safeAreaLayoutGuide.rightAnchor),
            //newsTitle
            newsTitle.topAnchor.constraint(equalTo: newsImage.safeAreaLayoutGuide.bottomAnchor, constant: 16),
            newsTitle.leftAnchor.constraint(equalTo: containerView.safeAreaLayoutGuide.leftAnchor, constant: 16),
            newsTitle.rightAnchor.constraint(equalTo: containerView.safeAreaLayoutGuide.rightAnchor, constant: -16),
            //newsPublishedAt
            newsPublishedAt.heightAnchor.constraint(equalToConstant: 25),
            newsPublishedAt.topAnchor.constraint(equalTo: newsTitle.safeAreaLayoutGuide.bottomAnchor),
            newsPublishedAt.leftAnchor.constraint(equalTo: containerView.safeAreaLayoutGuide.leftAnchor, constant: 16),
            newsPublishedAt.rightAnchor.constraint(equalTo: containerView.safeAreaLayoutGuide.rightAnchor, constant: -16),
            newsPublishedAt.bottomAnchor.constraint(equalTo: containerView.safeAreaLayoutGuide.bottomAnchor, constant: -16)
        ])
    }
}
