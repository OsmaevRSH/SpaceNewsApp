//
//  CoordinateConverter.swift
//  ARProject
//
//  Created by Руслан Осмаев on 30.03.2022.
//

import Foundation

struct Vector3 {
    var x: Double
    var y: Double
    var z: Double
}

class CoordinateConverter {
    
    /// Метод для перевода долготы и широты в трехмерные координаты
    /// - Parameters:
    ///   - latitude: Долгота
    ///   - longitude: Широта
    ///   - radius: Радиус
    /// - Returns: Трехмерные координаты
    static func convertTo3DecatrSystem(latitude: Double, longitude: Double, radius: Double) -> Vector3 {
        let x = radius * cos(longitude) * cos(latitude)
        let y = radius * cos(longitude) * sin(latitude)
        let z = radius * sin(longitude)
        return Vector3(x: x, y: y, z: z)
    }
}
