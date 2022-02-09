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

class NewsCellModel: Hashable {
    
    let identifier = UUID()
    var image: UIImage?
    let imageUrl: NSURL?
    var title: String?
    var publishedAt: String?
    let newsUrl: NSURL?
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(identifier)
    }
    
    static func == (lhs: NewsCellModel, rhs: NewsCellModel) -> Bool {
        return lhs.identifier == rhs.identifier
    }
    
    init(imageUrl: NSURL?, title: String?, publishedAt: String?, newsUrl: NSURL?) {
        self.image = nil
        self.imageUrl = imageUrl
        self.title = title
        self.publishedAt = publishedAt
        self.newsUrl = newsUrl
    }
}
