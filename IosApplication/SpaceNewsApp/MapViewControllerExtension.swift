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
                self.infoView.frame = CGRect(x: 0, y: self.view.frame.height, width: self.view.frame.width, height: 0)
                
            } completion: { _ in
                self.infoView.removeFromSuperview()
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
//
//        // Add annotation:
//		let annotation = MKPointAnnotation()
//		annotation.coordinate = coordinate
//		mapView.map.removeAnnotations(mapView.map.annotations)
//		mapView.map.addAnnotation(annotation)
        
        let geoCoder = CLGeocoder()
        
        let location = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)

        geoCoder.reverseGeocodeLocation(location, completionHandler: { (placemarks, error) -> Void in

            // Place details
            var placeMark: CLPlacemark!
            placeMark = placemarks?[0]

            if let city = placeMark.locality {
                print(city)
            }
            
            if let country = placeMark.country {
                print(country)
            }
            
            if let postalCode = placeMark.postalCode {
                print(postalCode)
            }

            if let locationName = placeMark.thoroughfare {
                print(locationName)
            }

            if let street = placeMark.administrativeArea {
                print(street)
            }
        })
        
        presentCityInformation()
	}
    
    func presentCityInformation() {
        if !isCityInfoPresented {
            isCityInfoPresented = true
            infoView.frame = CGRect(x: 0, y: self.view.frame.height, width: self.view.frame.width, height: 0)
            self.view.addSubview(infoView)
            UIView.animate(withDuration: 0.4) {
                self.infoView.frame = CGRect(x: 0, y: self.view.frame.height - 200, width: self.view.frame.width, height: 200)
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
	}
}
