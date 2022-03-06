//
//  BreakingNewsView.swift
//  SpaceNewsApp
//
//  Created by Руслан Осмаев on 02.02.2022.
//

import UIKit
import WebKit

class BreakingNewsView: UIView {
    
    var delegate: BreakingNewsDelegate!
    
    lazy var scrollView: UIScrollView = {
        var view = UIScrollView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var backBtn: UIButton = {
        var btn = UIButton(type: .system)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.backgroundColor = UIColor(displayP3Red: 245/250, green: 245/250, blue: 245/250, alpha: 0.9)
        btn.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        btn.layer.cornerRadius = 16
        btn.tintColor = .black
        btn.addTarget(self, action: #selector(backButtonHandler), for: .touchUpInside)
        return btn
    }()
    
    lazy var detailBtn: UIButton = {
        var btn = UIButton(type: .system)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.backgroundColor = UIColor(displayP3Red: 245/250, green: 245/250, blue: 245/250, alpha: 0.9)
        btn.setImage(UIImage(systemName: "ellipsis"), for: .normal)
        btn.layer.cornerRadius = 16
        btn.tintColor = .black
        return btn
    }()
    
    lazy var containerView: UIView = {
        var container = UIView()
        container.translatesAutoresizingMaskIntoConstraints = false
        return container
    }()
	
    lazy var newsImage: CustomUIImageView = {
        var image = CustomUIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    lazy var headerBtnView: UIView = {
        var view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var newsTitle: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Title"
        label.font = UIFont(name: "SF Pro Text", size: 15)
        label.font = .systemFont(ofSize: 15, weight: .semibold)
        label.numberOfLines = 0
        return label
    }()
    
    lazy var newsInfo: UILabel = {
       var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = UIFont(name: "SF Pro Text", size: 13)
        label.font = .systemFont(ofSize: 13, weight: .regular)
        return label
    }()
	
	private func addConstraints() {
		NSLayoutConstraint.activate([
            //scrollView
            scrollView.topAnchor.constraint(equalTo: self.topAnchor),
            scrollView.widthAnchor.constraint(equalTo: self.widthAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            //containerView
            containerView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            containerView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            containerView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            //newsImage
            newsImage.topAnchor.constraint(equalTo: containerView.topAnchor),
            newsImage.widthAnchor.constraint(equalTo: containerView.widthAnchor),
            newsImage.heightAnchor.constraint(equalToConstant: 250),
            //newsTitle
            newsTitle.topAnchor.constraint(equalTo: newsImage.bottomAnchor, constant: 16),
            newsTitle.leftAnchor.constraint(equalTo: newsImage.leftAnchor, constant: 16),
            newsTitle.rightAnchor.constraint(equalTo: newsImage.rightAnchor, constant: -16),
            //newsInfo
            newsInfo.topAnchor.constraint(equalTo: newsTitle.bottomAnchor, constant: 8),
            newsInfo.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 16),
            newsInfo.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -16),
            newsInfo.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -16),
            //headerBtnView
            headerBtnView.topAnchor.constraint(equalTo: self.topAnchor, constant: 16),
            headerBtnView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16),
            headerBtnView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -16),
            headerBtnView.heightAnchor.constraint(equalToConstant: 32),
            //backBtn
            backBtn.centerYAnchor.constraint(equalTo: headerBtnView.centerYAnchor),
            backBtn.leftAnchor.constraint(equalTo: headerBtnView.leftAnchor),
            backBtn.widthAnchor.constraint(equalToConstant: 32),
            backBtn.heightAnchor.constraint(equalToConstant: 32),
            //detailBtn
            detailBtn.centerYAnchor.constraint(equalTo: headerBtnView.centerYAnchor),
            detailBtn.rightAnchor.constraint(equalTo: headerBtnView.rightAnchor),
            detailBtn.widthAnchor.constraint(equalToConstant: 32),
            detailBtn.heightAnchor.constraint(equalToConstant: 32),
		])
	}
	
	override init(frame: CGRect) {
		super.init(frame: frame)
        addSubview(scrollView)
        scrollView.addSubview(containerView)
        containerView.addSubview(newsImage)
        containerView.addSubview(newsInfo)
        containerView.addSubview(newsTitle)
        addSubview(headerBtnView)
        headerBtnView.addSubview(backBtn)
        headerBtnView.addSubview(detailBtn)
		addConstraints()
        backgroundColor = .systemBackground
        self.layer.cornerRadius = 22
        self.layer.masksToBounds = true
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
    
    @objc private func backButtonHandler() {
        delegate.backButtonHandler()
    }
}
