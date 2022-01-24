import UIKit
import MapKit

class MapViewController: UIViewController {
	
//	var location: CLLocation!
	var locationManager = CLLocationManager()
	
		///Инициализация карты
	let mapView: MKMapView = {
		var map = MKMapView()
		map.translatesAutoresizingMaskIntoConstraints = false
		return map
	}()
	
		///Инициализация кнопки текущего местоположения
	let currentLocationButton: UIButton = {
		var button = UIButton(type: .system)
		button.translatesAutoresizingMaskIntoConstraints = false
		button.addTarget(self, action: #selector(getCurrentLocation), for: .touchUpInside)
		button.backgroundColor = .blue
		button.setTitle("Current location", for: .normal)
		button.setTitleColor(.white, for: .normal)
		button.setImage(UIImage(systemName: "location.fill"), for: .normal)
		button.layer.cornerRadius = 20
		return button
	}()
	
		/// Метод вызывается при создании контроллера
	override func viewDidLoad() {
		super.viewDidLoad()
		view.addSubview(mapView)
		view.addSubview(currentLocationButton)
		addMapConstraitns()
		addCurrentLocationButtonConstraints()
		initLocationManager()
	}
	
		/// Метод вызывается сразу после появления карты
		/// - Parameter animated: Будет ли отрабатывать анимация
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		checkLocationServices()
	}
	
		/// Метод инициализации параметров LocationManager
	private func initLocationManager() {
		locationManager.delegate = self
	}
	
		/// Метод для добавления contraints карты
	private func addMapConstraitns() {
		NSLayoutConstraint.activate([
			mapView.topAnchor.constraint(equalTo: view.topAnchor),
			mapView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
			mapView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
			mapView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor)
		])
	}
	
		///Метод для добавления constraints кнопки текущего местоположения
	private func addCurrentLocationButtonConstraints() {
		NSLayoutConstraint.activate([
			currentLocationButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			currentLocationButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
			currentLocationButton.widthAnchor.constraint(equalToConstant: 170),
			currentLocationButton.heightAnchor.constraint(equalToConstant: 40)
		])
	}
	
		///Обработчик нажатия на кнопку текущего местоположения
	@objc private func getCurrentLocation() {
//		let region = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: 2500, longitudinalMeters: 2500)
//		mapView.setRegion(region, animated: true)
		checkLocationAuthorization()
	}
	
		///Метод проверки, включен ли на устройстве сервис геолокации
		///TODO: хз как тут правильо сделть, locationManagerDidChangeAuthorization сам вызывается в начале
		///а при его вызове срабоатет checkLocationAuthorization
	func checkLocationServices() {
//		if CLLocationManager.locationServicesEnabled() {
////			checkLocationAuthorization()
//		} else {
//			present(AlertIfLocationServiceDisabled().getAlert(), animated: true, completion: nil)
//		}
		if CLLocationManager.locationServicesEnabled() != true {
			present(AlertIfLocationServiceDisabled.getAlert(), animated: true, completion: nil)
		}
	}
	
		///Метод провери разрешения для использования геолокации
	func checkLocationAuthorization() {
		switch CLLocationManager.authorizationStatus() {
			case .authorizedWhenInUse:
				mapView.showsUserLocation = true
				locationManager.startUpdatingLocation()
			case .notDetermined:
				locationManager.requestWhenInUseAuthorization()
			case .denied: // Show alert telling users how to turn on permissions
				present(AlertIfLocationServiceDisabled.getAlert(), animated: true, completion: nil) // Нужно использовать другой allert
			case .restricted: // Show an alert letting them know what’s up
				present(AlertIfLocationServiceDisabled.getAlert(), animated: true, completion: nil) // Нужно использовать другой allert
			case .authorizedAlways:
				break
			@unknown default:
				break
		}
	}
}

extension MapViewController : CLLocationManagerDelegate {
	
		/// Метод реализующий получение последнего местоположения пользователя
		/// - Parameters:
		///   - manager: Location Manager
		///   - locations: Location
	func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
		if let lastLocation = locations.last {
//			location = lastLocation
			let region = MKCoordinateRegion(center: lastLocation.coordinate, latitudinalMeters: 2500, longitudinalMeters: 2500)
			mapView.setRegion(region, animated: true)
			locationManager.stopUpdatingLocation()
		}
	}
	
		/// Метод срабатывает в случае изменения правил доступа к геолокации
		/// - Parameter manager: Location Manager
	func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
		checkLocationAuthorization()
	}
}
