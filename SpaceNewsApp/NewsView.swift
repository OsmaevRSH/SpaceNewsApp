//
//  NewsView.swift
//  SpaceNewsApp
//
//  Created by Руслан Осмаев on 01.02.2022.
//

import UIKit

class NewsView: UIView {

	lazy var newsTable: UITableView = {
		var table = UITableView()
		table.translatesAutoresizingMaskIntoConstraints = false
		return table
	}()
	
	private func addConstraints() {
		NSLayoutConstraint.activate([
			newsTable.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
			newsTable.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor),
			newsTable.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
			newsTable.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor)
		])
	}
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		addSubview(newsTable)
		addConstraints()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
}
