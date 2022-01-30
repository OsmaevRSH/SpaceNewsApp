//
//  MapViewDelegateImplementation.swift
//  SpaceNewsApp
//
//  Created by Руслан Осмаев on 30.01.2022.
//

import Foundation
import MapKit

// MARK: - MapViewDelegate
extension MapViewController: MapViewDelegate {
	
		/// Обработчик нажатия клавиши текущего местоположения
	func getCurrentLocation() {
		checkLocationAuthorization()
	}
}

// MARK: - CLLocationManagerDelegate
extension MapViewController : CLLocationManagerDelegate {
	
		/// Метод реализующий получение последнего местоположения пользователя
		/// - Parameters:
		///   - manager: Location Manager
		///   - locations: Location
	func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
		if let lastLocation = locations.last {
			let region = MKCoordinateRegion(center: lastLocation.coordinate, latitudinalMeters: 2500, longitudinalMeters: 2500)
			mapView.map.setRegion(region, animated: true)
			locationManager.stopUpdatingLocation()
		}
	}
	
		/// Метод срабатывает в случае изменения правил доступа к геолокации
		/// - Parameter manager: Location Manager
	func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
		checkLocationAuthorization()
	}
}
