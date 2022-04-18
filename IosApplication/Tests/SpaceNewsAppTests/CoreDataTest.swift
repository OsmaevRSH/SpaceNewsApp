//
//  CoreDataTest.swift
//  SpaceNewsApp
//
//  Created by Руслан Осмаев on 18.04.2022.
//

import XCTest
import CoreData
@testable import SpaceNewsApp

class CoreDataTest: XCTestCase {
    
    override func tearDownWithError() throws {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NewsReadingList.fetchRequest()
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        _ = try? NewsReadingList.dataManager.viewContext.execute(deleteRequest)
    }

    func testSaveAndFindObject() throws {
        //given
        let title = "title"
        let text = "text"
        let image = UIImage().pngData()
        let id = 100
        //when
        NewsReadingList.saveToReadingList(title: title, text: text, image: image, id: id)
        let result = NewsReadingList.findBy(id: id)
        //then
        XCTAssertNotNil(result)
    }
    
    func testFindNotExistentObject() throws {
        //given
        let id = 200
        //when
        let result = NewsReadingList.findBy(id: id)
        //then
        XCTAssertNil(result)
    }
    
    func testDeleteExistentObject() throws {
        //given
        let title = "title"
        let text = "text"
        let image = UIImage().pngData()
        let id = 100
        //when
        NewsReadingList.saveToReadingList(title: title, text: text, image: image, id: id)
        NewsReadingList.removeFromReadingList(by: id)
        let result = NewsReadingList.findBy(id: id)
        //then
        XCTAssertNil(result)
    }
    
    func testDeleteNotExistentObject() {
        //given
        let id = 100
        //then
        XCTAssertNoThrow(NewsReadingList.removeFromReadingList(by: id))
    }
}
