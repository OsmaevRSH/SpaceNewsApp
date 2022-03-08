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
    func swipeHandler() {
        if isCityInfoPresented {
            isCityInfoPresented = false
            UIView.animate(withDuration: 0.4) {
                self.cityViewController.cityView.frame = CGRect(x: 0, y: self.view.frame.height, width: self.view.frame.width, height: 0)
                
            } completion: { _ in
                self.cityViewController.willMove(toParent: nil)
                self.cityViewController.removeFromParent()
                self.cityViewController.cityView.removeFromSuperview()
                self.mapView.map.removeAnnotations(self.mapView.map.annotations)
            }
        }
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
		let annotation = MKPointAnnotation()
		annotation.coordinate = coordinate
		mapView.map.removeAnnotations(mapView.map.annotations)
		mapView.map.addAnnotation(annotation)
        
        let geoCoder = CLGeocoder()

        let location = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)

        geoCoder.reverseGeocodeLocation(location, completionHandler: { (placemarks, error) -> Void in

            // Place details
            var placeMark: CLPlacemark!
            placeMark = placemarks?[0]

            self.cityViewController.cityView.setupFields(city: placeMark.locality,
                                      country: placeMark.country,
                                      ZIP: placeMark.postalCode,
                                      address: placeMark.thoroughfare ?? "")
        })
        
        presentCityInformation()
	}
    
    func presentCityInformation() {
        if !isCityInfoPresented {
            isCityInfoPresented = true
            cityViewController.cityView.frame = CGRect(x: 0, y: self.view.frame.height, width: self.view.frame.width, height: 0)
            addChild(cityViewController)
            self.view.addSubview(cityViewController.view)
            cityViewController.didMove(toParent: self)
            UIView.animate(withDuration: 0.4) {
                self.cityViewController.cityView.frame = CGRect(x: 0, y: self.view.frame.height - self.cityInfoViewHeight, width: self.view.frame.width, height: self.cityInfoViewHeight)
            }
        }
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

// MARK: - HandleMapSearch
extension MapViewController: HandleMapSearch {
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
        
        presentCityInformation()
	}
}
