//
//  VideoViewController.swift
//  SpaceNewsApp
//
//  Created by Руслан Осмаев on 25.02.2022.
//

import UIKit
import Combine

class VideoViewController: UIViewController {

    private let VideosView = VideosListView()
    
    var viewModel: VideosListViewModel!
    
    var videosListData: [VideoCellModel] = []
    {
        didSet {
            var initialSnapshot = NSDiffableDataSourceSnapshot<Section, VideoCellModel>()
            initialSnapshot.appendSections([.main])
            initialSnapshot.appendItems(videosListData)
            self.dataSource.apply(initialSnapshot, animatingDifferences: false)
        }
    }
    
    var dataSource: UITableViewDiffableDataSource<Section, VideoCellModel>! = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Video"
        self.view.backgroundColor = .gray
        viewModel.getVideosList()
        setupDataSource()
        binding()
    }
    
    override func loadView() {
        view = VideosView
    }
    
    func binding() {
        viewModel.$videosListData
            .assign(to: \.videosListData, on: self)
            .store(in: &CancellableSetService.shared.set)
    }
    
    private func setupDataSource() {
        dataSource = UITableViewDiffableDataSource<Section, VideoCellModel>(tableView: VideosView.videosTable) {
            (tableView: UITableView, indexPath: IndexPath, fetchedItem: VideoCellModel) -> UITableViewCell? in
            let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath)
            cell.textLabel?.text = fetchedItem.title
            return cell
        }
    }
}
