//
//  RecomendationVideoCell.swift
//  SpaceNewsApp
//
//  Created by Руслан Осмаев on 06.03.2022.
//

import UIKit

class RecomendationVideoCell: UITableViewCell {
    
    static let cellId = "recomendedCellId"
    
    lazy var container: UIView = {
        var view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 13
        view.layer.masksToBounds = true
        view.backgroundColor = .systemBackground
        return view
    }()

    lazy var videoImage: CustomUIImageView = {
        var image = CustomUIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
        image.layer.cornerRadius = 13
        image.layer.masksToBounds = true
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFill
        return image
    }()

    lazy var videoTitle: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "SF Pro Text", size: 15)
        label.font = .systemFont(ofSize: 15, weight: .semibold)
        return label
    }()

    lazy var videoChanellTitle: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "SF Pro Text", size: 13)
        label.font = .systemFont(ofSize: 13, weight: .regular)
        label.textColor = UIColor(displayP3Red: 138/255, green: 138/255, blue: 142/255, alpha: 1)
        return label
    }()

    lazy var videoInfoStack: UIStackView = {
        var stack = UIStackView(arrangedSubviews: [
            videoTitle, videoChanellTitle
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
        container.addSubview(videoImage)
        container.addSubview(videoInfoStack)
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
            container.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 8),
            container.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 16),
            container.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            container.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor, constant: -16),

            videoImage.topAnchor.constraint(equalTo: container.topAnchor),
            videoImage.leftAnchor.constraint(equalTo: container.leftAnchor),
            videoImage.bottomAnchor.constraint(equalTo: container.bottomAnchor),
            videoImage.widthAnchor.constraint(equalTo: videoImage.heightAnchor, multiplier: 16.0/9.0),
            videoImage.heightAnchor.constraint(equalToConstant: 80),

            videoInfoStack.topAnchor.constraint(equalTo: container.topAnchor, constant: 16),
            videoInfoStack.leftAnchor.constraint(equalTo: videoImage.rightAnchor, constant: 16),
            videoInfoStack.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -16),
            videoInfoStack.rightAnchor.constraint(equalTo: container.rightAnchor, constant: -16)
        ])
    }
}
