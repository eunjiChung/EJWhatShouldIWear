//
//  EJLocationManagerTests.swift
//  EJWhatShouldIWearTests
//
//  Created by chungeunji on 2020/05/05.
//  Copyright © 2020 DEV_MOBILE_IOS_JUNIOR. All rights reserved.
//

import XCTest
@testable import EJWhatShouldIWear

class EJLocationManagerTests: XCTestCase {
    
    var sut: EJLocationManager!

    override func setUpWithError() throws {
        super.setUp()
        sut = EJLocationManager()
        sut.setRegionId()
    }

    override func tearDownWithError() throws {
        sut = nil
        super.tearDown()
    }
//
//    func testID_giveLocationString_getRegionId() {
//        let expectedCode = "11B20601"
//        let resultCode = sut.getRegionCode()
//        XCTAssertEqual(expectedCode, resultCode)
//    }
//
//    func testID_giveLocationString_getRegionId2() {
//        let expectedCode = "11C20301"
//        let resultCode = sut.getRegionCode()
//        XCTAssertEqual(expectedCode, resultCode)
//    }
//
//    func testID_giveLocationString_getRegionId3() {
//        let expectedCode = "11C20301"
//        let resultCode = sut.getRegionCode()
//        XCTAssertEqual(expectedCode, resultCode)
//    }
    
}
