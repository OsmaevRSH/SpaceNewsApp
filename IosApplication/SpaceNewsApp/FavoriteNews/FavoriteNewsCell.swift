//
//  FavoriteNewsCell.swift
//  SpaceNewsApp
//
//  Created by Руслан Осмаев on 09.03.2022.
//

import UIKit

class FavoriteNewsCell: UITableViewCell {
    
    static let reusibleIdentifier = "FavoriteNewsCell"
    
    lazy var container: UIView = {
        var view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 22
        view.layer.masksToBounds = true
        view.backgroundColor = .systemBackground
        return view
    }()

    lazy var newsImage: CustomUIImageView = {
        var image = CustomUIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
        image.layer.cornerRadius = 22
        image.layer.masksToBounds = true
        image.backgroundColor = .red
        return image
    }()

    lazy var newsTitle: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "SF Pro Text", size: 15)
        label.font = .systemFont(ofSize: 15, weight: .semibold)
        return label
    }()

    lazy var newsAuthor: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "SF Pro Text", size: 13)
        label.font = .systemFont(ofSize: 13, weight: .regular)
        label.textColor = UIColor(displayP3Red: 138/255, green: 138/255, blue: 142/255, alpha: 1)
        return label
    }()

    lazy var newsInfoStack: UIStackView = {
        var stack = UIStackView(arrangedSubviews: [
            newsTitle, newsAuthor
        ])
        stack.axis = .vertical
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.spacing = 8.0
        return stack
    }()

    /// Конструктор ячейки
    /// - Parameters:
    ///   - style: Стиль ячейки
    ///   - reuseIdentifier: Идентификатор ячейки для переиспользования
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(container)
        container.addSubview(newsImage)
        container.addSubview(newsInfoStack)
        addConstraints()
        backgroundColor = Colors.tableViewBackground.color
        self.selectionStyle = .none
    }

    /// Не используемый конструктор
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func addConstraints() {
        NSLayoutConstraint.activate([
            container.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 4),
            container.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 16),
            container.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -4),
            container.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor, constant: -16),

            newsImage.topAnchor.constraint(equalTo: container.topAnchor),
            newsImage.leftAnchor.constraint(equalTo: container.leftAnchor),
            newsImage.bottomAnchor.constraint(equalTo: container.bottomAnchor),
            newsImage.widthAnchor.constraint(equalTo: newsImage.heightAnchor, multiplier: 16.0/9.0),
            newsImage.heightAnchor.constraint(equalToConstant: 80),

            newsInfoStack.topAnchor.constraint(equalTo: container.topAnchor, constant: 16),
            newsInfoStack.leftAnchor.constraint(equalTo: newsImage.rightAnchor, constant: 16),
            newsInfoStack.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -16),
            newsInfoStack.rightAnchor.constraint(equalTo: container.rightAnchor, constant: -16)
        ])
    }
}
