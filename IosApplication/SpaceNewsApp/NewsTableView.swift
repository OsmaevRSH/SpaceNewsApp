//
//  NewsView.swift
//  SpaceNewsApp
//
//  Created by Руслан Осмаев on 01.02.2022.
//

import UIKit

class NewsTableView: UIView {
    
    /// Таблица для отображения новостей
	lazy var newsTable: UITableView = {
		var table = UITableView()
		table.translatesAutoresizingMaskIntoConstraints = false
        table.register(NewsTableViewCell.self, forCellReuseIdentifier: NewsTableViewCell.reusableCellIdenifier)
		table.rowHeight = UITableView.automaticDimension
		table.estimatedRowHeight =  600
        table.backgroundColor = Colors.tableViewBackground.color
        table.separatorStyle = .none
		return table
	}()
    
    /// Метод для добавления констрейнтов к таблице
	private func addConstraints() {
		NSLayoutConstraint.activate([
			newsTable.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
			newsTable.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor),
			newsTable.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
			newsTable.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor)
		])
	}
	
    /// Конструктор
    /// - Parameter frame: Frame таблицы
	override init(frame: CGRect) {
		super.init(frame: frame)
		addSubview(newsTable)
		addConstraints()
        self.backgroundColor = Colors.tableViewBackground.color
	}
	
    /// Не используемый конструктор
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
  
