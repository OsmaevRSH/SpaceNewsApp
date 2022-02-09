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
        image.layer.cornerRadius = 20
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    lazy var newsInfo: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
    lazy var newsPublishedAt: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
	
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubviews()
        addConstraints()
//        backgroundColor = .black.withAlphaComponent(0.9)
        let bgColorView = UIView()
        bgColorView.backgroundColor = .gray.withAlphaComponent(0.2)
        selectedBackgroundView = bgColorView
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubviews() {
        addSubview(newsImage)
        addSubview(newsInfo)
        addSubview(newsPublishedAt)
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            newsImage.heightAnchor.constraint(equalToConstant: 250),
            newsImage.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 8),
            newsImage.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 8),
            newsImage.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor, constant: -8),
            
            newsInfo.topAnchor.constraint(equalTo: newsImage.safeAreaLayoutGuide.bottomAnchor, constant: 8),
            newsInfo.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 8),
            newsInfo.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor, constant: -8),
            
            newsPublishedAt.heightAnchor.constraint(equalToConstant: 25),
            newsPublishedAt.topAnchor.constraint(equalTo: newsInfo.safeAreaLayoutGuide.bottomAnchor, constant: 8),
            newsPublishedAt.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 8),
            newsPublishedAt.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor, constant: -8),
            newsPublishedAt.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -8)
        ])
    }
}
