import UIKit
import MapKit

class MapViewController: UIViewController {
	
	var mapView = MapView()
	
	var locationManager = CLLocationManager()
	
		/// Метод вызывающийся при загрузке view
	override func loadView() {
		view = mapView
	}
	
		/// Метод вызывается при создании контроллера
	override func viewDidLoad() {
		super.viewDidLoad()
		locationManager.delegate = self
		mapView.delegate = self
	}
	
		/// Метод вызывается сразу после появления карты
		/// - Parameter animated: Будет ли отрабатывать анимация
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		checkLocationServices()
	}
	
		///Метод проверки, включен ли на устройстве сервис геолокации
	func checkLocationServices() {
		if CLLocationManager.locationServicesEnabled() != true {
			present(AlertIfLocationServiceDisabled.getAlert(), animated: true, completion: nil)
		}
	}
	
		///Метод провери разрешения для использования геолокации
	func checkLocationAuthorization() {
		switch CLLocationManager.authorizationStatus() {
			case .authorizedWhenInUse:
				mapView.map.showsUserLocation = true
				locationManager.startUpdatingLocation()
			case .notDetermined:
				locationManager.requestWhenInUseAuthorization()
			case .denied:
				present(AlertIfLocationServiceDisabled.getAlert(), animated: true, completion: nil) // Нужно использовать другой allert
			case .restricted:
				present(AlertIfLocationServiceDisabled.getAlert(), animated: true, completion: nil) // Нужно использовать другой allert
			case .authorizedAlways:
				break
			@unknown default:
				break
		}
	}
}
