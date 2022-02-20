//
//  ResultCityPageViewController.swift
//  SpaceNewsApp
//
//  Created by Руслан Осмаев on 14.02.2022.
//

import UIKit
import MapKit

enum Pages: CaseIterable {
    case table
    case map
    var name: String {
        switch self {
        case .table:
            return "table"
        case .map:
            return "map"
        }
    }
    var index: Int {
        switch self {
        case .table:
            return 0
        case .map:
            return 1
        }
    }
}

class ResultCityPageViewController: UIPageViewController {
    
    var tableCityViewController: TableCityViewController!
    var mapCityViewController: MapCityViewController!
    var viewModel: ResultCityPageViewModel!
    
    private let pages: [Pages] = Pages.allCases
    private var currentIndex = 0
    
    func setupFields(latitude: String, longitude: String, radius: String, minPopulation: String, maxPopulation: String) {
        viewModel.getCitys(latitude: latitude,
                           longitude: longitude,
                           radius: radius,
                           minPopulation: minPopulation,
                           maxPopulation: maxPopulation)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Citys"
        self.delegate = self
        self.dataSource = self
        self.setViewControllers([tableCityViewController], direction: .forward, animated: true, completion: nil)
    }
}

extension ResultCityPageViewController: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let currentVC = viewController as? MapCityViewController else {
            return nil
        }
        let index = currentVC.page.index
        if index == 0 {
            return nil
        }
        return tableCityViewController
    }
        
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let currentVC = viewController as? TableCityViewController else {
            return nil
        }
        let index = currentVC.page.index
        if index >= self.pages.count - 1 {
            return nil
        }
        return mapCityViewController
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return self.pages.count
    }
    
//    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
//        return 0
//    }
}
