import UIKit

class BaseTabBarController: UITabBarController {
    
    var mapNavController: MapNavController!
    var newsNavController: NewsNavController!
    var videoNavController: VideoNavController!
    
    private func configureControllers() {
        let mapTabBarItem = UITabBarItem(
            title: "Map",
            image: UIImage(systemName: "mappin.and.ellipse"),
            selectedImage: UIImage(systemName: "mappin.and.ellipse")
            )
        mapNavController.tabBarItem = mapTabBarItem
        
        let newsTabBarItem = UITabBarItem(
            title: "News",
            image: UIImage(systemName: "newspaper"),
            selectedImage: UIImage(systemName: "newspaper")
            )
        newsNavController.tabBarItem = newsTabBarItem
        
        let videoTabBarItem = UITabBarItem(
            title: "Videos",
            image: UIImage(systemName: "play.rectangle"),
            selectedImage: UIImage(systemName: "play.rectangle")
            )
        videoNavController.tabBarItem = videoTabBarItem
    }
	
    override func viewDidLoad() {
        super.viewDidLoad()
		self.tabBar.backgroundColor = .white
        self.tabBar.isTranslucent = false
//		UserDefaults.standard.set(false, forKey: "LaunchBefore") //Need to see onboarding
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureControllers()
        self.setViewControllers([newsNavController, videoNavController, mapNavController], animated: true)
//        self.setViewControllers([mapNavController], animated: true)
    }
}
