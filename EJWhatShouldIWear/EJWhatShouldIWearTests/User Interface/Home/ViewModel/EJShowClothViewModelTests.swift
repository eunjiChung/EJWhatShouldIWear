//
//  EJShowClothViewModelTests.swift
//  EJWhatShouldIWearTests
//
//  Created by chungeunji on 2020/06/01.
//  Copyright © 2020 DEV_MOBILE_IOS_JUNIOR. All rights reserved.
//

import XCTest
@testable import EJWhatShouldIWear

class EJShowClothViewModelTests: XCTestCase {
    
    var sut: EJShowClothViewModel!
    
    override func setUp() {
        super.setUp()
        sut = EJShowClothViewModel()
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func testDescription_initiateDescription_takeOuter() {
        // given
        let expected = "아침에 추우니 겉옷을 챙기세요~"
        // when
        let result = sut.morningInfo(with: .morningMinTemp, 12, 6, "").description
        // then
        XCTAssertEqual(expected, result)
    }
    
    func testDescription_initiateDescription_nothing() {
        // given
        let expected = ""
        // when
        let result = sut.morningInfo(with: .morningMinTemp, 18, 6, "").description
        // then
        XCTAssertEqual(expected, result)
    }
    
    func testDescription_initiateDescription_rainy() {
        // given
        let expected = "아침에 비가 내려요 "
        // when
        let result = sut.morningInfo(with: .rainFallType, 1, 6, "").description
        // then
        XCTAssertEqual(expected, result)
    }
    
    func testDescription_initiateDescription_snow() {
        // given
        let expected = "아침에 눈이 내려요 "
        // when
        let result = sut.morningInfo(with: .rainFallType, 3, 6, "").description
        // then
        XCTAssertEqual(expected, result)
    }
    
    func testDescription_initiateDescription_shower() {
        // given
        let expected = "아침에 소나기가 내려요 "
        // when
        let result = sut.morningInfo(with: .rainFallType, 4, 6, "").description
        // then
        XCTAssertEqual(expected, result)
    }
    
    func testDescription_giveOuterDescription_getAsItIs() {
        // given
        let expected = "아침에 추우니 겉옷을 챙기세요~"
        
        // when
        let originDescription = sut.morningInfo(with: .morningMinTemp, 12, 6, "").description
        let result = sut.morningInfo(with: .morningMinTemp, 10, 1, originDescription).description
        // then
        XCTAssertEqual(expected, result)
    }
    
    func testDescription_giveOuterDescription_getRainy() {
        // given
        let expected = "아침에 비가 내려요 추우니 겉옷을 챙기세요~"
        // when
        let originDescription = sut.morningInfo(with: .morningMinTemp, 12, 10, "").description
        let result = sut.morningInfo(with: .rainFallType, 1, 1, originDescription).description
        // then
        XCTAssertEqual(expected, result)
    }
    
    func test_giveDescription_getDescription() {
        // given
        // when
        let originDescription = sut.morningInfo(with: .morningMinTemp, 20, 20, "").description
        let firstDesc = sut.morningInfo(with: .morningMinTemp, 26, 1, originDescription).description
        let twoDesc = sut.morningInfo(with: .rainFallType, 1, 1, firstDesc).description
        let third = sut.morningInfo(with: .rainFallType, 4, 1, twoDesc).description
        let result = sut.morningInfo(with: .rainFallType, 3, 1, third).description
        print("❤️ " + result)
        // then
        XCTAssertNotNil(result)
    }
    
    // MARK: - Day Description
    func test_initializer_getDescription() {
        // given
        let expected = "오늘 일교차가 커요! 겉옷을 챙기세요~"
        // when
        let originDescription = sut.dayDescription(with: .noonMaxTemp, 25, 10, "")
        // then
        XCTAssertEqual(expected, originDescription)
    }
    
    func test_initializer_getDescription1() {
        // given
        let expected = "오늘 일교차가 커요! 겉옷을 챙기세요~"
        // when
        let originDescription = sut.dayDescription(with: .noonMaxTemp, 1, 10, "낮에 비가 내려요 오늘 일교차가 커요! 겉옷을 챙기세요~")
        // then
        XCTAssertEqual(expected, originDescription)
    }
    
    func test_initializer_getDescription2() {
        // given
        let expected = "낮에 날씨가 맑아요! "
        // when
        let originDescription = sut.dayDescription(with: .skyCode, 1, 10, "아침에 비가 내려요 ")
        // then
        XCTAssertEqual(expected, originDescription)
    }
    
    func testDate() {
        let date = "20200627"
        
        let startIndex = date.index(date.startIndex, offsetBy: 4)
        let monthEndIndex = date.index(after: startIndex)
        let monthString = "\(date[startIndex...monthEndIndex])"
    
        let dayStartIndex = date.index(after: monthEndIndex)
        let dayEndIndex = date.index(after: dayStartIndex)
        let dayString = "\(date[dayStartIndex...dayEndIndex])"
        
        print(monthString)
        print(dayString)
        
        XCTAssertNotNil(monthString)
        XCTAssertNotNil(dayString)
    }
    
    
    
}
