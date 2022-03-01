//
//  NewsTableViewCell.swift
//  SpaceNewsApp
//
//  Created by Руслан Осмаев on 02.02.2022.
//

import UIKit

class NewsTableViewCell: UITableViewCell {
		
    lazy var newsImage: UIImageView = {
        var image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        image.layer.cornerRadius = 22
        image.layer.masksToBounds = true
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    lazy var newsInfo: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "SF Pro Text", size: 15)
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 15, weight: .semibold)
        return label
    }()
    
    lazy var newsPublishedAt: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "SF Pro Text", size: 13)
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 13, weight: .regular)
        return label
    }()
    
    lazy var containerView: UIView = {
        var view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 22
        view.backgroundColor = .systemBackground
        return view
    }()
	
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubviews()
        addConstraints()
        self.selectionStyle = .none
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubviews() {
        self.backgroundColor = Colors.tableViewBackground.color
        addSubview(containerView)
        containerView.addSubview(newsImage)
        containerView.addSubview(newsInfo)
        containerView.addSubview(newsPublishedAt)
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            
            containerView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 4),
            containerView.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 16),
            containerView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -4),
            containerView.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor, constant: -16),
            
            newsImage.heightAnchor.constraint(equalToConstant: 300),
            newsImage.topAnchor.constraint(equalTo: containerView.safeAreaLayoutGuide.topAnchor),
            newsImage.leftAnchor.constraint(equalTo: containerView.safeAreaLayoutGuide.leftAnchor),
            newsImage.rightAnchor.constraint(equalTo: containerView.safeAreaLayoutGuide.rightAnchor),
            
            newsInfo.topAnchor.constraint(equalTo: newsImage.safeAreaLayoutGuide.bottomAnchor, constant: 16),
            newsInfo.leftAnchor.constraint(equalTo: containerView.safeAreaLayoutGuide.leftAnchor, constant: 16),
            newsInfo.rightAnchor.constraint(equalTo: containerView.safeAreaLayoutGuide.rightAnchor, constant: -16),
            
            newsPublishedAt.heightAnchor.constraint(equalToConstant: 25),
            newsPublishedAt.topAnchor.constraint(equalTo: newsInfo.safeAreaLayoutGuide.bottomAnchor),
            newsPublishedAt.leftAnchor.constraint(equalTo: containerView.safeAreaLayoutGuide.leftAnchor, constant: 16),
            newsPublishedAt.rightAnchor.constraint(equalTo: containerView.safeAreaLayoutGuide.rightAnchor, constant: -16),
            newsPublishedAt.bottomAnchor.constraint(equalTo: containerView.safeAreaLayoutGuide.bottomAnchor, constant: -16)
        ])
    }
}
