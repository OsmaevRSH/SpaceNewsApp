//
//  MapView.swift
//  SpaceNewsApp
//
//  Created by Руслан Осмаев on 30.01.2022.
//

import UIKit
import MapKit

class MapView: UIView {
	
	weak var delegate: MapViewDelegate?
	
	// MARK: - Constants
	private let currentLocationButtonWidth: CGFloat = 170
	private let currentLocationButtonHeight: CGFloat = 40
	
	// MARK: - UI Elements
	
		/// Инициализация карты
	lazy var map: MKMapView = {
		var map = MKMapView()
		map.translatesAutoresizingMaskIntoConstraints = false
		return map
	}()
	
		/// Инициализация кнопки текущего местоположения
	lazy var currentLocationButton: UIButton = {
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
	
		/// Метод для добавления contraints
	private func addConstraitns() {
		NSLayoutConstraint.activate([
			///Constraints карты
			map.topAnchor.constraint(equalTo: topAnchor),
			map.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor),
			map.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
			map.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor),
			///Constraints кнопки текущего местоположения
			currentLocationButton.centerXAnchor.constraint(equalTo: centerXAnchor),
			currentLocationButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -20),
			currentLocationButton.widthAnchor.constraint(equalToConstant: currentLocationButtonWidth),
			currentLocationButton.heightAnchor.constraint(equalToConstant: currentLocationButtonHeight)
		])
	}
	
		/// Метод для добавления всех subview
	private func addSubviews() {
		addSubview(map)
		addSubview(currentLocationButton)
	}
	
	// MARK: - Init
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		addSubviews()
		addConstraitns()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	// MARK: - Handlers
	
		/// Метод для обработки нажания на кнопку текущего местоположения
	@objc private func getCurrentLocation(){
		delegate?.getCurrentLocation()
	}
}
