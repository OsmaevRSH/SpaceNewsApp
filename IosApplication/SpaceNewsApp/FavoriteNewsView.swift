//
//  FavoriteNewsView.swift
//  SpaceNewsApp
//
//  Created by Руслан Осмаев on 09.03.2022.
//

import UIKit

class FavoriteNewsView: UIView {
    
    lazy var newsTable: UITableView = {
        var table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.register(FavoriteNewsCell.self, forCellReuseIdentifier: FavoriteNewsCell.reusibleIdentifier)
        return table
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(newsTable)
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            newsTable.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            newsTable.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor),
            newsTable.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            newsTable.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor)
        ])
    }
}
