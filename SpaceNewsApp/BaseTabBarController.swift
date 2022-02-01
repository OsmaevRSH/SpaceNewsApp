import UIKit

class BaseTabBarController: UITabBarController {

	let mapNavController: UINavigationController = {
		let navController = MapNavController()
		let tabBarItem = UITabBarItem(
			title: "Map",
			image: UIImage(systemName: "map"),
			selectedImage: UIImage(systemName: "map"))
		navController.tabBarItem = tabBarItem
		return navController
	}()
	
	let marsNavController: UINavigationController = {
		let navController = MarsNavController()
		let tabBarItem = UITabBarItem(
			title: "Map",
			image: UIImage(systemName: "airplane"),
			selectedImage: UIImage(systemName: "airplane"))
		navController.tabBarItem = tabBarItem
		return navController
	}()
	
	let newsNavController: UINavigationController = {
		let navController = NewsNavController()
		let tabBarItem = UITabBarItem(
			title: "News",
			image: UIImage(systemName: "newspaper"),
			selectedImage: UIImage(systemName: "newspaper"))
		navController.tabBarItem = tabBarItem
		return navController
	}()
	
    override func viewDidLoad() {
        super.viewDidLoad()
		self.tabBar.backgroundColor = .white
		self.setViewControllers([mapNavController, marsNavController, newsNavController], animated: true)
//		UserDefaults.standard.set(false, forKey: "LaunchBefore") //Need to see onboarding
    }
}
