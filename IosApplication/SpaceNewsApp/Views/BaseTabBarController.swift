import UIKit

class BaseTabBarController: UITabBarController {
    
    var mapNavController: MapNavController!
    var newsNavController: NewsNavController!
    var videoNavController: VideoNavController!
    var arNavController: ARNavController!
    
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
        
        let arTabBarItem = UITabBarItem(
            title: "AR",
            image: UIImage(systemName: "airplane.circle"),
            selectedImage: UIImage(systemName: "airplane.circle")
        )
        arNavController.tabBarItem = arTabBarItem
    }
	
    override func viewDidLoad() {
        super.viewDidLoad()
		self.tabBar.backgroundColor = .white
        self.tabBar.isTranslucent = false
		UserDefaults.standard.set(false, forKey: "LaunchBefore") //Need to see onboarding
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureControllers()
        if UIAccessibility.isVoiceOverRunning {
            self.setViewControllers([newsNavController, videoNavController, mapNavController], animated: true)
        }
        else {
            self.setViewControllers([newsNavController, videoNavController, mapNavController, arNavController], animated: true)
        }
    }
}
