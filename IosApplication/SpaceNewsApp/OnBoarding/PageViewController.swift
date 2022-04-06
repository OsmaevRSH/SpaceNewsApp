import Foundation
import UIKit
import SwiftUI

struct PageViewController: UIViewControllerRepresentable {
	
	@Binding var currentPageIndex: Int
	
	var viewControllers: [UIViewController]
	
	func makeCoordinator() -> Coordinator {
		Coordinator(self)
	}
	
	func makeUIViewController(context: Context) -> UIPageViewController {
		let pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal)
		pageViewController.dataSource = context.coordinator
		pageViewController.delegate = context.coordinator
		return pageViewController
	}
	
	func updateUIViewController(_ pageViewController: UIPageViewController, context: Context) {
		pageViewController.setViewControllers([viewControllers[currentPageIndex]], direction: .forward, animated: true)
	}
	
	class Coordinator: NSObject, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
		
		var parent: PageViewController
		
		init(_ pageViewController: PageViewController) {
			self.parent = pageViewController
		}
		
		func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
			guard let index = parent.viewControllers.firstIndex(of: viewController), index != 0 else {
				return nil
			}
			return parent.viewControllers[index - 1]
			
		}
		
		func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
			guard let index = parent.viewControllers.firstIndex(of: viewController), index + 1 != parent.viewControllers.count else {
				return nil
			}
			return parent.viewControllers[index + 1]
		}
		
		func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
			if completed,
			   let visibleViewController = pageViewController.viewControllers?.first,
			   let index = parent.viewControllers.firstIndex(of: visibleViewController)
			{
				parent.currentPageIndex = index
			}
		}
	}
	
}
