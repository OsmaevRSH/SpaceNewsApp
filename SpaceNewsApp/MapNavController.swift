import UIKit

class MapNavController: UINavigationController {
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		let mapViewController = MapViewController()
		self.viewControllers = [mapViewController]
	}
}
