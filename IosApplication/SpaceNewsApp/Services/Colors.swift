//
//  Colors.swift
//  SpaceNewsApp
//
//  Created by Руслан Осмаев on 01.03.2022.
//

import Foundation
import UIKit


enum Colors {
    
    case tableViewBackground
    
    var color: UIColor {
        switch self {
        case .tableViewBackground:
            return UIColor(red: 242 / 255, green: 242 / 255, blue: 242 / 255, alpha: 1)
        }
    }
}
