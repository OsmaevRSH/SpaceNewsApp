//
//  MapViewDelegate.swift
//  SpaceNewsApp
//
//  Created by Руслан Осмаев on 30.01.2022.
//

import Foundation
import UIKit
import MapKit

protocol MapViewDelegate: AnyObject {
	
    /// Обработчик нажатия клавиши текущего местоположения
	func getCurrentLocation()
    
    /// Обработчик нажатия на карту
	func createPinOnTap(gestureRecognizer: UITapGestureRecognizer)
    
    /// Метод обработки свайпа вниз view с детальной информацией об отмеченной точке
    func swipeHandler()
    
    /// Метод добавления пина на карту через поиск
    func dropPinZoomIn(placemark: MKPlacemark)
}
