//
//  NewsReadingList+CoreDataProperties.swift
//  SpaceNewsApp
//
//  Created by Руслан Осмаев on 14.03.2022.
//
//

import Foundation
import CoreData


extension NewsReadingList {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<NewsReadingList> {
        return NSFetchRequest<NewsReadingList>(entityName: "NewsReadingList")
    }

    @NSManaged public var title: String?
    @NSManaged public var text: String?
    @NSManaged public var image: Data?
    @NSManaged public var uuid: UUID?

}

extension NewsReadingList : Identifiable {

}
