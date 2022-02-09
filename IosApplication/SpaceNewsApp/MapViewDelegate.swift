//
//  MapViewDelegate.swift
//  SpaceNewsApp
//
//  Created by Руслан Осмаев on 30.01.2022.
//

import Foundation
import UIKit

protocol MapViewDelegate: AnyObject {
	
		/// Обработчик нажатия клавиши текущего местоположения
	func getCurrentLocation()
	
		/// Обработчик нажатия на карту
	func createPinOnTap(gestureRecognizer: UITapGestureRecognizer)
	
		/// Метод для отправки запроса на содание фото
	func CreateRequestToCreatePhoto()
}
