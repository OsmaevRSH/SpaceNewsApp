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
    static func convertTo3DecatrSystem(latitude: Double, longitude: Double, radius: Double) -> Vector3 {
        let x = radius * cos(latitude) * cos(longitude)
        let y = radius * cos(latitude) * sin(longitude)
        let z = radius * sin(latitude)
        return Vector3(x: x, y: y, z: z)
    }
}
