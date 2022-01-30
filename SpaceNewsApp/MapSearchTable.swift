//
//  MapSearchBar.swift
//  SpaceNewsApp
//
//  Created by Руслан Осмаев on 30.01.2022.
//

import UIKit
import MapKit

class MapSearchTable: UITableViewController {
	
	var matchingItems:[MKMapItem] = []
	var mapView: MKMapView?
	let cellId = "cellId"
	var handleMapSearchDelegate:HandleMapSearch?
	
	
		/// Метод для получения адреса найденого объекта
		/// - Parameter selectedItem: Найденый объект
		/// - Returns: Вычесленный адрей
	func parseAddress(selectedItem:MKPlacemark) -> String {
			// put a space between "4" and "Melrose Place"
		let firstSpace = (selectedItem.subThoroughfare != nil && selectedItem.thoroughfare != nil) ? " " : ""
			// put a comma between street and city/state
		let comma = (selectedItem.subThoroughfare != nil || selectedItem.thoroughfare != nil) && (selectedItem.subAdministrativeArea != nil || selectedItem.administrativeArea != nil) ? ", " : ""
			// put a space between "Washington" and "DC"
		let secondSpace = (selectedItem.subAdministrativeArea != nil && selectedItem.administrativeArea != nil) ? " " : ""
		let addressLine = String(
			format:"%@%@%@%@%@%@%@",
			// street number
			selectedItem.subThoroughfare ?? "",
			firstSpace,
			// street name
			selectedItem.thoroughfare ?? "",
			comma,
			// city
			selectedItem.locality ?? "",
			secondSpace,
			// state
			selectedItem.administrativeArea ?? ""
		)
		return addressLine
	}
}

// MARK: - UISearchResultsUpdating
extension MapSearchTable: UISearchResultsUpdating {
	func updateSearchResults(for searchController: UISearchController) {
		guard let mapView = mapView,
			  let searchBarText = searchController.searchBar.text else { return }
		let request = MKLocalSearch.Request()
		request.naturalLanguageQuery = searchBarText
		request.region = mapView.region
		let search = MKLocalSearch(request: request)
		search.start { response, _ in
			guard let response = response else {
				return
			}
			self.matchingItems = response.mapItems
			self.tableView.reloadData()
		}
	}
}

// MARK: - TableViewDelegate, TableViewDataSource
extension MapSearchTable {
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return matchingItems.count
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		var cell = tableView.dequeueReusableCell(withIdentifier: cellId)
		if cell == nil {
			cell = UITableViewCell(style: .subtitle, reuseIdentifier: cellId)
		}
		let selectedItem = matchingItems[indexPath.row].placemark
		
		guard let cell = cell else {
			return UITableViewCell()
		}
		
		cell.textLabel?.text = selectedItem.name
		cell.detailTextLabel?.text = parseAddress(selectedItem: selectedItem)
		return cell
	}
	
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let selectedItem = matchingItems[indexPath.row].placemark
		handleMapSearchDelegate?.dropPinZoomIn(placemark: selectedItem)
		dismiss(animated: true, completion: nil)
	}
}
