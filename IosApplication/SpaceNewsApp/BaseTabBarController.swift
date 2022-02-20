import UIKit

class BaseTabBarController: UITabBarController {
    
    var mapNavController: MapNavController!
    var marsNavController: MarsNavController!
    var newsNavController: NewsNavController!
    
    private func configureControllers() {
        let mapTabBarItem = UITabBarItem(
            title: "Map",
            image: UIImage(systemName: "map"),
            selectedImage: UIImage(systemName: "map")
            )
        mapNavController.tabBarItem = mapTabBarItem
        
        let newsTabBarItem = UITabBarItem(
            title: "News",
            image: UIImage(systemName: "newspaper"),
            selectedImage: UIImage(systemName: "newspaper")
            )
        newsNavController.tabBarItem = newsTabBarItem
        
        let marsTabBarItem = UITabBarItem(
            title: "Mars",
            image: UIImage(systemName: "airplane"),
            selectedImage: UIImage(systemName: "airplane")
            )
        marsNavController.tabBarItem = marsTabBarItem
    }
	
    override func viewDidLoad() {
        super.viewDidLoad()
		self.tabBar.backgroundColor = .white
//		UserDefaults.standard.set(false, forKey: "LaunchBefore") //Need to see onboarding
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureControllers()
        self.setViewControllers([mapNavController, newsNavController], animated: true)
    }
}
