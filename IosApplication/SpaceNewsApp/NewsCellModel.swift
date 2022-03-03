//
//  NewsCellModel.swift
//  SpaceNewsApp
//
//  Created by Руслан Осмаев on 09.02.2022.
//

import Foundation
import UIKit

enum Section {
    case main
}

class NewsCellModel {
    
    let imageUrl: NSURL?
    var title: String?
    var publishedAt: String?
    let newsUrl: NSURL?
    let newsId: Int
    
    init(imageUrl: NSURL?, title: String?, publishedAt: String?, newsUrl: NSURL?, newsId: Int) {
        self.imageUrl = imageUrl
        self.title = title
        self.publishedAt = publishedAt
        self.newsUrl = newsUrl
        self.newsId = newsId
    }
}
