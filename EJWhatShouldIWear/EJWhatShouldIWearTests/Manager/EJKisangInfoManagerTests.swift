//
//  EJKisangInfoManagerTests.swift
//  EJWhatShouldIWearTests
//
//  Created by chungeunji on 2020/05/31.
//  Copyright © 2020 DEV_MOBILE_IOS_JUNIOR. All rights reserved.
//

import XCTest
@testable import EJWhatShouldIWear

class EJKisangInfoManagerTests: XCTestCase {

    var sut: EJKisangInfoManager!
    
    override func setUpWithError() throws {
        super.setUp()
        sut = EJKisangInfoManager()
    }

    override func tearDownWithError() throws {
        sut = nil
        super.tearDown()
    }

//    func test_giveDate_generateBaseTime1() {
//        // given
//        let expected = "0200"
//
//        // when
////        let date = "20200531"
//        let hour = 2
//        let minute = 11
//        let result = sut.generateBaseTime
//
//        // then
//        XCTAssertEqual(expected, result())
//    }
//
//    func test_giveDate_generateBaseTime2() {
//        // given
//        let expected = "2300"
//
//        // when
//        //        let date = "20200531"
//        let hour = 0
//        let minute = 0
//        let result = sut.generateBaseTime
//
//        // then
//        XCTAssertEqual(expected, result)
//    }
//
//    func test_giveDate_generateBaseTime3() {
//        // given
//        let expected = "2300"
//
//        // when
//        //        let date = "20200531"
//        let hour = 1
//        let minute = 45
//        let result = sut.generateBaseTime
//
//        // then
//        XCTAssertEqual(expected, result)
//    }
//
//    func test_giveDate_generateBaseTime4() {
//        // given
//        let expected = "0200"
//
//        // when
//        //        let date = "20200531"
//        let hour = 5
//        let minute = 7
//        let result = sut.generateBaseTime
//
//        // then
//        XCTAssertEqual(expected, result)
//    }
//
//    func test_giveDate_generateBaseTime5() {
//        // given
//        let expected = "0500"
//
//        // when
//        //        let date = "20200531"
//        let hour = 7
//        let minute = 7
//        let result = sut.generateBaseTime
//
//        // then
//        XCTAssertEqual(expected, result)
//    }
    
    func test_giveDate_generateBaseDate1() {
        // given
//        let expectedDate = "20200601"
//        // when
//        let result = sut.generateBaseDate()
//
//        // then
////        print("❤️ Calendar: \(year)-\(month)-\(day)")
//        XCTAssertEqual(result, expectedDate)
    }
    
    func text_giveDate_generateProperDate() {
        let result = sut.generateBaseDate("2020-06-02", 2, 17)
        print("❤️", result)
    }
}
