import UIKit

class MarsNavController: UINavigationController {
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		let marsViewController = MarsViewController()
		self.viewControllers = [marsViewController]
		
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
