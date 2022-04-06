//
//  NewsReadingList+CoreDataClass.swift
//  SpaceNewsApp
//
//  Created by Руслан Осмаев on 14.03.2022.
//
//

import Foundation
import CoreData


public class NewsReadingList: NSManagedObject {
    
    private static let dataManager = DataStoreManager.shared
    
    class func saveToReadingList(title: String?, text: String?, image: Data?, id: Int) {
        let news = NewsReadingList(context: dataManager.viewContext)
        news.uuid = Int64(id)
        news.title = title
        news.text = text
        news.image = image
        dataManager.saveContext()
    }
    
    class func removeFromReadingList(by id: Int) {
        guard let breakingNews = findBy(id: id) else { return }
        dataManager.viewContext.delete(breakingNews)
        dataManager.saveContext()
    }
    
    class func findBy(id: Int) -> NewsReadingList? {
        let fetchRequest = NewsReadingList.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "uuid = %d", id)
        guard let news = try? dataManager.viewContext.fetch(fetchRequest) else { return nil }
        guard let breakingNews = news.first else { return nil }
        return breakingNews
    }
}
