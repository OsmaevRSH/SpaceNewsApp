//
//  ImageCacheTest.swift
//  SpaceNewsApp
//
//  Created by Руслан Осмаев on 18.04.2022.
//

import XCTest
@testable import SpaceNewsApp

class ImageCacheTest: XCTestCase {
    
    override func tearDownWithError() throws {
        ImageCacheService.shared.clearCache()
    }

    func testGetNotExistentObject() throws {
        //given
        let url: NSURL = NSURL(string: "test.url.com")!
        //when
        let result = ImageCacheService.shared.getImageFromCache(for: url)
        //then
        XCTAssertNil(result)
    }
    
    func testAddAndGetObject() throws {
        //given
        let url: NSURL = NSURL(string: "test.url.com")!
        //when
        ImageCacheService.shared.saveImageToCache(for: UIImage(), from: url)
        let result = ImageCacheService.shared.getImageFromCache(for: url)
        //then
        XCTAssertNotNil(result)
    }
}
