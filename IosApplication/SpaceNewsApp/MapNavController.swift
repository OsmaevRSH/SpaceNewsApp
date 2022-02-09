import UIKit

class MapNavController: UINavigationController {
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		let mapViewController = MapViewController()
		self.viewControllers = [mapViewController]
		
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
