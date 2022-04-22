import UIKit
import SwiftUI

struct LaunchView: View {
	@EnvironmentObject var viewlaunch: ViewLaunch
	
	var body: some View {
		VStack {
			if viewlaunch.currentPage == "onBoardingView" {
				OnBoardigView()
			} else if viewlaunch.currentPage == "ContentView" {
				BaseTabBarControllerOnSwiftUI()
					.edgesIgnoringSafeArea(.all)
			}
		}
	}
}

class ViewLaunch: ObservableObject {
	
	init() {
		if !UserDefaults.standard.bool(forKey: "LaunchBefore") {
			currentPage = "onBoardingView"
		} else {
			currentPage = "ContentView"
		}
	}
	
	@Published var currentPage: String
}

struct BaseTabBarControllerOnSwiftUI: UIViewControllerRepresentable {
	
	typealias UIViewControllerType = BaseTabBarController
	
	func makeUIViewController(context: Context) -> UIViewControllerType {
		let myViewController = AssemblyLayer.configureBaseTabBarController()
		return myViewController
	}
	
	func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
	}
}
