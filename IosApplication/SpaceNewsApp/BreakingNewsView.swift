//
//  BreakingNewsView.swift
//  SpaceNewsApp
//
//  Created by Руслан Осмаев on 02.02.2022.
//

import UIKit
import WebKit

class BreakingNewsView: UIView {
	
    lazy var newsImage: UIImageView = {
        var image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    lazy var newsInfo: UITextView = {
       var label = UITextView()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isEditable = false
        label.font = .systemFont(ofSize: 18, weight: .regular)
        return label
    }()
	
	private func addConstraints() {
		NSLayoutConstraint.activate([
            //newsImage
            newsImage.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            newsImage.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor),
            newsImage.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor),
            newsImage.heightAnchor.constraint(equalToConstant: 250),
            //newsInfo
            newsInfo.topAnchor.constraint(equalTo: newsImage.bottomAnchor),
            newsInfo.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor),
            newsInfo.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor),
            newsInfo.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
		])
	}
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		addSubview(newsImage)
        addSubview(newsInfo)
		addConstraints()
        backgroundColor = .systemBackground
        self.layer.cornerRadius = 22
        self.layer.masksToBounds = true
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
