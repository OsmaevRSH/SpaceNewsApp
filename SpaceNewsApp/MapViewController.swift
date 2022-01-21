import UIKit
import MapKit

class MapViewController: UIViewController {
	let locationManager = CLLocationManager()
	
	let Map: MKMapView = {
		var map = MKMapView()
		map.translatesAutoresizingMaskIntoConstraints = false
		return map
	}()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		view.addSubview(Map)
		addMapConstrains()
	}
	
	private func addMapConstrains() {
		NSLayoutConstraint.activate([
			Map.topAnchor.constraint(equalTo: view.topAnchor),
			Map.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
			Map.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
			Map.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor)
		])
	}
}
