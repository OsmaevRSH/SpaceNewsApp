//
//  NewsCacheTest.swift
//  SpaceNewsApp
//
//  Created by Руслан Осмаев on 18.04.2022.
//

import XCTest
@testable import SpaceNewsApp

class NewsCacheTest: XCTestCase {

    override func tearDownWithError() throws {
        NewsCacheService.shared.clearCache()
    }

    func testGetNotExistentObject() throws {
        //given
        let url: NSURL = NSURL(string: "test.url.com")!
        //when
        let result = NewsCacheService.shared.getImageFromCache(for: url)
        //then
        XCTAssertNil(result)
    }
    
    func testAddAndGetObject() throws {
        //given
        let url: NSURL = NSURL(string: "test.url.com")!
        let text: NSString = "TestString"
        //when
        NewsCacheService.shared.saveImageToCache(for: text, from: url)
        let result = NewsCacheService.shared.getImageFromCache(for: url)
        //then
        XCTAssertEqual(result, text)
    }

}
