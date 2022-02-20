//
//  TableCityViewController.swift
//  SpaceNewsApp
//
//  Created by Руслан Осмаев on 15.02.2022.
//

import UIKit
import Combine

class TableCityViewController: UIViewController {

    var viewModel: ResultCityPageViewModel!
    var page: Pages
    var cancellableSet: Set<AnyCancellable> = []
    
    var dataStorage: [City] = [] {
        didSet {
            table.reloadData()
        }
    }
    
    func binding() {
        viewModel.$dataStorage
            .sink { [weak self] value in
                self?.dataStorage = value.cities
            }
            .store(in: &cancellableSet)
    }
    
    lazy var table: UITableView = {
        var table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.delegate = self
        table.dataSource = self
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        view.addSubview(table)
        addConstraints()
    }
    
    init() {
        self.page = Pages.table
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addConstraints() {
        NSLayoutConstraint.activate([
            table.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            table.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            table.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            table.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor)
        ])
    }
}

extension TableCityViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dataStorage.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = dataStorage[indexPath.row].name
        return cell
    }    
}
