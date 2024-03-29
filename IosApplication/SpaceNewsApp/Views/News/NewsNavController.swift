//
//  NewsNavController.swift
//  SpaceNewsApp
//
//  Created by Руслан Осмаев on 01.02.2022.
//

import UIKit

class NewsNavController: UINavigationController {
    
    var newsViewController: NewsViewController!

    override func viewDidLoad() {
        super.viewDidLoad()
        
		self.viewControllers = [newsViewController]
		
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
