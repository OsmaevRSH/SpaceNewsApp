//
//  BreakingNewsView.swift
//  SpaceNewsApp
//
//  Created by Руслан Осмаев on 02.02.2022.
//

import UIKit
import WebKit

class BreakingNewsView: UIView {
	
	lazy var webView: WKWebView = {
		var view = WKWebView()
		view.translatesAutoresizingMaskIntoConstraints = false
		return view
	}()
	
	private func addConstraints() {
		NSLayoutConstraint.activate([
			webView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
			webView.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor),
			webView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
			webView.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor)
		])
	}
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		addSubview(webView)
		addConstraints()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
