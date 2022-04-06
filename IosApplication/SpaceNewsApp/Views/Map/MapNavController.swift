import UIKit

class MapNavController: UINavigationController {
	
    var mapViewController: MapViewController!
    
	override func viewDidLoad() {
		super.viewDidLoad()
		
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
