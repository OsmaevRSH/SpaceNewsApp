//
//  FavoriteNewsViewController.swift
//  SpaceNewsApp
//
//  Created by Руслан Осмаев on 09.03.2022.
//

import UIKit

class FavoriteNewsViewController: UIViewController {

    private let newsView = FavoriteNewsView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Saved news"
        view.backgroundColor = .systemBackground
        newsView.newsTable.delegate = self
        newsView.newsTable.dataSource = self
    }
    
    override func loadView() {
        view = newsView
    }
}

extension FavoriteNewsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: FavoriteNewsCell.reusibleIdentifier, for: indexPath) as? FavoriteNewsCell
        else {
            return FavoriteNewsCell()
        }
        cell.newsTitle.text = "Title"
        cell.newsAuthor.text = "Author"
        return cell
    }
}
