//
//  NewsView.swift
//  SpaceNewsApp
//
//  Created by Руслан Осмаев on 01.02.2022.
//

import UIKit

class NewsView: UIView {
	
	lazy var cellId = "cellId"

	// MARK: - UI elements
	lazy var newsTable: UITableView = {
		var table = UITableView()
		table.translatesAutoresizingMaskIntoConstraints = false
		let newsCell = UINib(nibName: "NewsCell", bundle: nil)
		table.register(newsCell, forCellReuseIdentifier: cellId)
		table.rowHeight = UITableView.automaticDimension
		table.estimatedRowHeight =  600
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
	
	// MARK: - Initialize
	override init(frame: CGRect) {
		super.init(frame: frame)
		addSubview(newsTable)
		addConstraints()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
}
