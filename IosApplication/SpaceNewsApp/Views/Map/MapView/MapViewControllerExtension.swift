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
    
    /// Метод обработки свайпа вниз view с детальной информацией об отмеченной точке
    func swipeHandler() {
        cityInformationController.removeController(from: self)
        self.mapView.map.removeAnnotations(self.mapView.map.annotations)
    }
    
    /// Обработчик нажатия клавиши текущего местоположения
	func getCurrentLocation() {
		mapView.map.removeAnnotations(mapView.map.annotations)
		checkLocationAuthorization()
	}
	
    /// Метод обработки нажатия на карту
    /// - Parameter gestureRecognizer: Обработчик нажатия
	func createPinOnTap(gestureRecognizer: UITapGestureRecognizer) {
		let gestureRecognizer = gestureRecognizer.location(in: mapView)
		let coordinate = mapView.map.convert(gestureRecognizer, toCoordinateFrom: mapView)

        // Add annotation:
		addNewsAnnotation(coordinate: coordinate)
        cityInformationController.presentController(from: self)
	}
    
    func addNewsAnnotation(coordinate: CLLocationCoordinate2D) {
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        mapView.map.removeAnnotations(mapView.map.annotations)
        mapView.map.addAnnotation(annotation)
        cityInformationController.viewModel.getInfoAboutCurrentCity(latitude: "\(coordinate.latitude)", longitude: "\(coordinate.longitude)")
        cityInformationController.viewModel.getCitys(latitude: "\(coordinate.latitude)", longitude: "\(coordinate.longitude)")
        let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        let region = MKCoordinateRegion(center: coordinate, span: span)
        mapView.map.setRegion(region, animated: true)
        if cityInformationController.cityView.cityCollectionView.indexPathsForVisibleItems.first != nil {
            cityInformationController.cityView.cityCollectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .right, animated: true)
        }
    }
    
    /// Метод добавления пина на карту через поиск
    func dropPinZoomIn(placemark: MKPlacemark){
            // cache the pin
        selectedPin = placemark
            // clear existing pins
        mapView.map.removeAnnotations(mapView.map.annotations)
        let annotation = MKPointAnnotation()
        annotation.coordinate = placemark.coordinate
        annotation.title = placemark.name
        if placemark.locality != nil &&
           placemark.administrativeArea != nil {
            annotation.subtitle = "(city) (state)"
        }
        mapView.map.addAnnotation(annotation)
        let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        let region = MKCoordinateRegion(center: placemark.coordinate, span: span)
        mapView.map.setRegion(region, animated: true)
        
        addNewsAnnotation(coordinate: placemark.coordinate)
        cityInformationController.presentController(from: self)
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
