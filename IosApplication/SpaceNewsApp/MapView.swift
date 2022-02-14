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
		let tap = UITapGestureRecognizer(target: self, action: #selector(createPinOnTap(gestureRecognizer:)))
		map.addGestureRecognizer(tap)
		return map
	}()
	
		/// Инициализация кнопки текущего местоположения
	lazy var currentLocationButton: UIButton = {
		var button = UIButton(type: .system)
		button.translatesAutoresizingMaskIntoConstraints = false
		button.addTarget(self, action: #selector(getCurrentLocation), for: .touchUpInside)
		button.backgroundColor = .blue.withAlphaComponent(0.7)
		button.setTitle("Current location", for: .normal)
		button.setTitleColor(.white, for: .normal)
		button.setImage(UIImage(systemName: "location.fill"), for: .normal)
		button.layer.cornerRadius = 20
		return button
	}()
	
		/// Кнопка создания фото
	lazy var photoButton: UIButton = {
		var button = UIButton(type: .system)
		button.translatesAutoresizingMaskIntoConstraints = false
		button.layer.cornerRadius = 20
		button.setTitle("Setup API settings", for: .normal)
		button.setImage(UIImage(systemName: "camera"), for: .normal)
		button.backgroundColor = .blue.withAlphaComponent(0.7)
		button.setTitleColor(.white, for: .normal)
		button.addTarget(self, action: #selector(CreateRequestToCreatePhoto), for: .touchUpInside)
		return button
	}()
	
		/// Метод для добавления contraints
	private func addConstraitns() {
		NSLayoutConstraint.activate([
			///Constraints карты
			map.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
			map.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor),
			map.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
			map.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor),
			///Constraints кнопки текущего местоположения
			currentLocationButton.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 16),
			currentLocationButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -32),
			currentLocationButton.heightAnchor.constraint(equalToConstant: currentLocationButtonHeight),
			///Constraints кнопка для создания фото
			photoButton.centerYAnchor.constraint(equalTo: currentLocationButton.centerYAnchor),
			photoButton.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor, constant: -16),
			photoButton.widthAnchor.constraint(equalTo: currentLocationButton.widthAnchor),
			photoButton.heightAnchor.constraint(equalToConstant: currentLocationButtonHeight),
			photoButton.leftAnchor.constraint(equalTo: currentLocationButton.rightAnchor, constant: 32)
		])
	}
	
		/// Метод для добавления всех subview
	private func addSubviews() {
		addSubview(map)
		addSubview(currentLocationButton)
		addSubview(photoButton)
	}
	
	// MARK: - Init
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		addSubviews()
		addConstraitns()
		backgroundColor = .white.withAlphaComponent(0.8)
		tintColor = .white
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	// MARK: - Handlers
	
		/// Метод для обработки нажания на кнопку текущего местоположения
	@objc private func getCurrentLocation(){
		delegate?.getCurrentLocation()
	}
	
		/// Метод для обработки нажатия на карту
		/// - Parameter gestureRecognizer: Обработкик нажатия
	@objc private func createPinOnTap(gestureRecognizer: UITapGestureRecognizer) {
		delegate?.createPinOnTap(gestureRecognizer: gestureRecognizer)
	}
	
		/// Метод для отправки запроса на содание фото
	@objc private func CreateRequestToCreatePhoto() {
		delegate?.CreateRequestToCreatePhoto()
	}
}
