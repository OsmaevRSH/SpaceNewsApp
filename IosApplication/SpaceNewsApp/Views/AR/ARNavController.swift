//
//  ARNavController.swift
//  SpaceNewsApp
//
//  Created by Руслан Осмаев on 02.04.2022.
//

import UIKit

class ARNavController: UINavigationController {
    
    var arViewController: ARViewController!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.viewControllers = [arViewController]
        
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .systemBackground
        appearance.titleTextAttributes = [.foregroundColor: UIColor.black]
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.black]
        
        self.navigationBar.tintColor = .black
        self.navigationBar.standardAppearance = appearance
        self.navigationBar.compactAppearance = appearance
        self.navigationBar.scrollEdgeAppearance = appearance
    }
}
