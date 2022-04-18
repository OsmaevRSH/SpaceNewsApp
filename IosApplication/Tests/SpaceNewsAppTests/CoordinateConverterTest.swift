//
//  SpaceNewsAppTests.swift
//  SpaceNewsAppTests
//
//  Created by Руслан Осмаев on 21.01.2022.
//

import XCTest
@testable import SpaceNewsApp

class CoordinateConverterTest: XCTestCase {

    func testCoordinateConverterAllIsNil() throws {
        //when
        let result = CoordinateConverter.convertTo3DecatrSystem(latitude: 0, longitude: 0, radius: 0)
        //then
        let expectedResult = Vector3(x: 0, y: 0, z: 0)
        XCTAssertEqual(result, expectedResult)
    }
    
    func testCoordinateConverterRadiusIsNil() throws {
        //when
        let result = CoordinateConverter.convertTo3DecatrSystem(latitude: 30, longitude: 30, radius: 0)
        //then
        let expectedResult = Vector3(x: 0, y: 0, z: 0)
        XCTAssertEqual(result, expectedResult)
    }
    
    func testCoordinateConverter() throws {
        //when
        let result = CoordinateConverter.convertTo3DecatrSystem(latitude: 30, longitude: 30, radius: 1)
        //then
        let x = 1 * cos(30.0) * cos(30.0)
        let y = 1 * cos(30.0) * sin(30.0)
        let z = 1 * sin(30.0)
        let expectedResult = Vector3(x: x, y: y, z: z)
        XCTAssertEqual(result, expectedResult)
    }
    
    func testCoordinateConverterNegativeValue() throws {
        //when
        let result = CoordinateConverter.convertTo3DecatrSystem(latitude: -30, longitude: -30, radius: 1)
        //then
        let x = 1 * cos(-30.0) * cos(-30.0)
        let y = 1 * cos(-30.0) * sin(-30.0)
        let z = 1 * sin(-30.0)
        let expectedResult = Vector3(x: x, y: y, z: z)
        XCTAssertEqual(result, expectedResult)
    }
}
