//
//  VideoNavController.swift
//  SpaceNewsApp
//
//  Created by Руслан Осмаев on 25.02.2022.
//

import UIKit

class VideoNavController: UINavigationController {

    var videoViewController: VideoViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewControllers = [videoViewController]
        
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .white
        appearance.titleTextAttributes = [.foregroundColor: UIColor.black]
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.black]
        
        self.navigationBar.tintColor = .black
        self.navigationBar.standardAppearance = appearance
        self.navigationBar.compactAppearance = appearance
        self.navigationBar.scrollEdgeAppearance = appearance
    }
}
