//
//  HttpHelperTest.swift
//  SpaceNewsApp
//
//  Created by Руслан Осмаев on 18.04.2022.
//

import XCTest
@testable import SpaceNewsApp

class HttpHelperTest: XCTestCase {

    func testCreateURLWithoutQueryParams() throws {
        //given
        let url = "test.com"
        //when
        let result = HttpHelper.generateURL(url: url, queryItem: nil)
        //then
        let expectedResult = URL(string: url + "?")
        XCTAssertEqual(result, expectedResult)
    }
    
    func testCreateURLWithQueryParams() throws {
        //given
        let url = "test.com"
        let params = ["test1": "1", "hello": "world"]
        //when
        let result = HttpHelper.generateURL(url: url, queryItem: params)
        //then
        let expectedResult1 = URL(string: "test.com?test1=1&hello=world")
        let expectedResult2 = URL(string: "test.com?hello=world&test1=1")
        XCTAssert(result == expectedResult1 || result == expectedResult2)

    }
}
