//
//  FavoriteNewsViewController.swift
//  SpaceNewsApp
//
//  Created by Руслан Осмаев on 09.03.2022.
//

import UIKit
import CoreData

class FavoriteNewsViewController: UIViewController {

    private let newsView = FavoriteNewsView()
    
    let dataManager = DataStoreManager.shared
    
    var fetchedResultsController: NSFetchedResultsController<NewsReadingList>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Saved news"
        view.backgroundColor = .systemBackground
        newsView.newsTable.delegate = self
        newsView.newsTable.dataSource = self
        setupDataSource()
    }
    
    override func loadView() {
        view = newsView
    }
    
    private func setupDataSource() {
        let fetchRequest: NSFetchRequest<NewsReadingList> = NewsReadingList.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "title", ascending: false)
        fetchRequest.sortDescriptors = [sortDescriptor]
        fetchRequest.fetchLimit = .max
        
        fetchedResultsController = NSFetchedResultsController(
            fetchRequest: fetchRequest,
            managedObjectContext: dataManager.viewContext,
            sectionNameKeyPath: nil,
            cacheName: nil)
        
        fetchedResultsController.delegate = self
        
        do {
            try fetchedResultsController.performFetch()
        } catch let error {
            fatalError("\(error)")
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        newsView.newsTable.reloadData()
    }
}

extension FavoriteNewsViewController: UITableViewDataSource, UITableViewDelegate, NSFetchedResultsControllerDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fetchedResultsController.sections?[section].numberOfObjects ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: FavoriteNewsCell.reusibleIdentifier, for: indexPath) as? FavoriteNewsCell
        else {
            return FavoriteNewsCell()
        }
        
        let item = fetchedResultsController.object(at: indexPath)
        
        cell.newsTitle.text = item.title
        cell.newsAuthor.text = item.text
        if let image = item.image {
            cell.newsImage.image = UIImage(data: image)
        }
        return cell
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        guard let indexPath = indexPath else { return }
        switch type {
        case .delete:
            newsView.newsTable.deleteRows(at: [indexPath], with: .middle)
        default:
            break
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle {
        case .delete:
            let item = fetchedResultsController.object(at: indexPath)
            dataManager.viewContext.delete(item)
            dataManager.saveContext()
        default:
            break
        }
    }
}
