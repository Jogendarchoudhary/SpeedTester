//
//  DatabaseTests.swift
//  SpeedTester
//
//  Created by Ranosys on 16/06/17.
//  Copyright © 2017 Jogendar. All rights reserved.
//

import XCTest
@testable import SpeedTester

class DatabaseTests: XCTestCase {
    
    var dbManager:DBManager!
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        dbManager = DBManager()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
        dbManager = nil
    }
    
    func testDatabaseIsCreated() {
        XCTAssertTrue(dbManager.createDataBase())
    }
    func testValueIsInsertedonTable() {
        let testData = "30"
       XCTAssertTrue(dbManager.insertDataIntoTable(speedValue: testData))
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
