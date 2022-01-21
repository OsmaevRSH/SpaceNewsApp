import UIKit

class MarsNavController: UINavigationController {
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		let marsViewController = MarsViewController()
		self.viewControllers = [marsViewController]
	}
}
