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
        let videoNavController = VideoNavController()
        let breakingNewsViewController = BreakingNewsViewController()
        let breakingNewsViewModel = BreakingNewsViewModel()
        let videosListViewModel = VideosListViewModel()
        let breakingVideoViewController = BreakingVideoViewController()
        let favoriteViewController = FavoriteNewsViewController()
        let detailButtonViewController = DetailButtonViewController()
        
        baseTabBarController.mapNavController = mapNavController
        baseTabBarController.newsNavController = newsNavController
        baseTabBarController.videoNavController = videoNavController
        videoNavController.videoViewController = videoViewController
        videoViewController.viewModel = videosListViewModel
        videoViewController.breakingVideoViewController = breakingVideoViewController
        breakingVideoViewController.viewModel = videosListViewModel
        mapNavController.mapViewController = mapViewController
        newsNavController.newsViewController = newsViewController
        newsViewController.viewModel = newsViewModel
        newsViewController.favoriteNewsViewController = favoriteViewController
        newsViewController.breakingNewsViewController = breakingNewsViewController
        breakingNewsViewController.breakingNewsViewModel = breakingNewsViewModel
        breakingNewsViewController.detailButtonViewController = detailButtonViewController
        favoriteViewController.breakingNewsViewController = breakingNewsViewController
        
        return baseTabBarController
    }
}
