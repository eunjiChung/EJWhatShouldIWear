//
//  EJWhatShouldIWearUITests.swift
//  EJWhatShouldIWearUITests
//
//  Created by DEV_MOBILE_IOS_JUNIOR on 31/01/2019.
//  Copyright © 2019 DEV_MOBILE_IOS_JUNIOR. All rights reserved.
//

import XCTest

class EJWhatShouldIWearUITests: XCTestCase {

    let app = XCUIApplication()
    
    override func setUp() {
        continueAfterFailure = false
        app.launch()
    }

    override func tearDown() {
    }

    func testTable() {
        let table = app.tables["mainTableView"]
        let cell = table.cells["showClothCell"]
        XCTAssertTrue(cell.exists)
        // 셀 탭하기
        cell.tap()
        // 탭하면 옷들 나타남
        let resultCell = table.cells["moreClothesCell"]
        XCTAssertTrue(resultCell.exists)
    }

}
