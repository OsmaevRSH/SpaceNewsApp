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
    
    class func saveToReadingList(title: String?, text: String?, image: Data?) {
        let news = NewsReadingList(context: dataManager.viewContext)
        news.uuid = UUID()
        news.title = title
        news.text = text
        news.image = image
        dataManager.saveContext()
    }
    
    class func removeFromReadingList(by uuid: UUID) {
        let fetchRequest = NewsReadingList.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "uuid = %@", uuid as CVarArg)
        guard let news = try? dataManager.viewContext.fetch(fetchRequest) else { return }
        guard let breakingNews = news.first else { return }
        dataManager.viewContext.delete(breakingNews)
        dataManager.saveContext()
    }
}
