//
//  AssemblyLayer.swift
//  SpaceNewsApp
//
//  Created by Руслан Осмаев on 20.02.2022.
//

import Foundation
import UIKit

class AssemblyLayer {
    
    class func configureBaseTabBarController() -> UITabBarController {
        
        let baseTabBarController = BaseTabBarController()
        let newsNavController = NewsNavController()
        let newsViewController = NewsViewController()
        let newsViewModel = NewsViewModel()
        let videoViewController = VideoViewController()
        let mapNavController = MapNavController()
        let mapViewController = MapViewController()
        let marsNavController = MarsNavController()
        let videoNavController = VideoNavController()
        let breakingNewsViewController = BreakingNewsViewController()
        let breakingNewsViewModel = BreakingNewsViewModel()
        let setupApiSettingsViewController = SetupApiSettingsViewController()
        let resultCityPageViewController = ResultCityPageViewController(
            transitionStyle: .scroll, navigationOrientation: .horizontal)
        let mapCityViewController = MapCityViewController()
        let tableCityViewController = TableCityViewController()
        let resultCityPageViewModel = ResultCityPageViewModel()
        let videosListViewModel = VideosListViewModel()
        let breakingVideoViewController = BreakingVideoViewController()
        
        baseTabBarController.mapNavController = mapNavController
        baseTabBarController.newsNavController = newsNavController
        baseTabBarController.marsNavController = marsNavController
        baseTabBarController.videoNavController = videoNavController
        videoNavController.videoViewController = videoViewController
        videoViewController.viewModel = videosListViewModel
        videoViewController.breakingVideoViewController = breakingVideoViewController
        breakingVideoViewController.viewModel = videosListViewModel
        mapNavController.mapViewController = mapViewController
        mapViewController.setupApiSettingsViewController = setupApiSettingsViewController
        setupApiSettingsViewController.resultCityPageViewController = resultCityPageViewController
        resultCityPageViewController.mapCityViewController = mapCityViewController
        resultCityPageViewController.tableCityViewController = tableCityViewController
        resultCityPageViewController.viewModel = resultCityPageViewModel
        mapCityViewController.viewModel = resultCityPageViewModel
        tableCityViewController.viewModel = resultCityPageViewModel
        newsNavController.newsViewController = newsViewController
        newsViewController.viewModel = newsViewModel
        newsViewController.breakingNewsViewController = breakingNewsViewController
        breakingNewsViewController.breakingNewsViewModel = breakingNewsViewModel
        breakingNewsViewController.breakingNewsView.delegate = newsViewController
        
        return baseTabBarController
    }
}
