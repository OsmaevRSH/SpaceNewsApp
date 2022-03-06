//
//  VideoCellModel.swift
//  SpaceNewsApp
//
//  Created by Руслан Осмаев on 27.02.2022.
//

import Foundation
import UIKit

class VideoCellModel: Hashable {
    
    let identifier = UUID()
    var image: UIImage?
    let imageUrl: NSURL?
    var title: String?
    var chanelTitle: String?
    var videoId: String?
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(identifier)
    }
    
    static func == (lhs: VideoCellModel, rhs: VideoCellModel) -> Bool {
        return lhs.identifier == rhs.identifier
    }
    
    init(imageUrl: NSURL?, title: String?, videoId: String?, chanelTitle: String?) {
        self.image = nil
        self.imageUrl = imageUrl
        self.title = title
        self.videoId = videoId
        self.chanelTitle = chanelTitle
    }
}
