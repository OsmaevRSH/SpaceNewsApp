//
//  HttpServiceTest.swift
//  SpaceNewsAppTests
//
//  Created by Руслан Осмаев on 18.04.2022.
//

import XCTest
import Combine
@testable import SpaceNewsApp

class HttpServiceTest: XCTestCase {
    
    var cancelSet: Set<AnyCancellable>!

    override func setUpWithError() throws {
        cancelSet = Set<AnyCancellable>()
    }

    override func tearDownWithError() throws {
        cancelSet = nil
    }

    func testNewsGetNews() throws {
        //given
        let expect = XCTestExpectation()
        //when
        NewsHttpService.shared.getNews(newsOffset: 0)
            .sink { item in
                expect.fulfill()
            }
            .store(in: &cancelSet)
        //then
        self.wait(for: [expect], timeout: 2)
    }
    
    func testNewsGetNewsDescription() throws {
        //given
        let expect = XCTestExpectation()
        let newsURL = URL(string: "https://spacenews.com/comspoc-executive-to-join-dods-space-policy-office/")!
        let newsId = 14727
        
        //when
        NewsHttpService.shared.getNewsDescription(url: newsURL, newsId: newsId)
            .sink { _ in
                expect.fulfill()
            }
            .store(in: &cancelSet)
        //then
        self.wait(for: [expect], timeout: 10)
    }
    
    func testVideoGetVideos() throws {
        //given
        let expect = XCTestExpectation()
        
        //when
        VideoHttpService.shared.getVideos(loadFirstPage: false)
            .sink { _ in
                expect.fulfill()
            }
            .store(in: &cancelSet)
        //then
        self.wait(for: [expect], timeout: 2)
    }
    
    func testVideoGetLiveVideos() throws {
        //given
        let expect = XCTestExpectation()
        
        //when
        VideoHttpService.shared.getLiveVideos()
            .sink { _ in
                expect.fulfill()
            }
            .store(in: &cancelSet)
        //then
        self.wait(for: [expect], timeout: 2)
    }
    
    func testCityGetCurrentCityInformation() throws {
        //given
        let expect = XCTestExpectation()
        
        //when
        CityHttpService.shared.getCurrentCityInformation(latitude: "55.74", longitude: "37.61")
            .sink { _ in
                expect.fulfill()
            }
            .store(in: &cancelSet)
        //then
        self.wait(for: [expect], timeout: 2)
    }
    
    func testCityGetCitysInArea() throws {
        //given
        let expect = XCTestExpectation()
        
        //when
        CityHttpService.shared.getCitysInArea(latitude: "55.74", longitude: "37.61")
            .sink { _ in
                expect.fulfill()
            }
            .store(in: &cancelSet)
        //then
        self.wait(for: [expect], timeout: 2)
    }
    
    func testStarlinkGetStarlinks() throws {
        //given
        let expect = XCTestExpectation()
        
        //when
        StarlinkHttpService.shared.getStarlinks()
            .sink { _ in
                expect.fulfill()
            }
            .store(in: &cancelSet)
        //then
        self.wait(for: [expect], timeout: 2)
    }
}
