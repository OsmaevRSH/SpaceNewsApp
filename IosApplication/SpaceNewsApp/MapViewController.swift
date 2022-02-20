import UIKit
import MapKit

protocol HandleMapSearch {
	func dropPinZoomIn(placemark:MKPlacemark)
}

class MapViewController: UIViewController {
	
    var setupApiSettingsViewController: SetupApiSettingsViewController!
    
	lazy var mapView = MapView()
	var selectedPin: MKPlacemark?
	var seacrhController: UISearchController?
	var locationSearchTable: MapSearchTable!
	lazy var locationManager = CLLocationManager()
	
		/// Метод вызывающийся при загрузке view
	override func loadView() {
		view = mapView
	}
	
		/// Метод вызывается при создании контроллера
	override func viewDidLoad() {
		super.viewDidLoad()
		locationManager.delegate = self
		mapView.delegate = self
		createMapSearchBar()
		locationSearchTable.mapView = mapView.map
		locationSearchTable.handleMapSearchDelegate = self
	}
	
		/// Метод вызывается сразу после появления карты
		/// - Parameter animated: Будет ли отрабатывать анимация
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		checkLocationServices()
	}
	
		/// Метод для добавления searchBar на карту
	private func createMapSearchBar() {
		locationSearchTable = MapSearchTable()
		seacrhController = UISearchController(searchResultsController: locationSearchTable)
		seacrhController?.searchResultsUpdater = locationSearchTable
		let searchBar = seacrhController?.searchBar
		searchBar?.sizeToFit()
		searchBar?.placeholder = "Search for places"
		navigationItem.titleView = seacrhController?.searchBar
		seacrhController?.hidesNavigationBarDuringPresentation = false
		seacrhController?.obscuresBackgroundDuringPresentation = true
		definesPresentationContext = true
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
