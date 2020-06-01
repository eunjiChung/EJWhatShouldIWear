//
//  EJConvertHelperTests.swift
//  EJWhatShouldIWearTests
//
//  Created by chungeunji on 2020/05/31.
//  Copyright © 2020 DEV_MOBILE_IOS_JUNIOR. All rights reserved.
//

import XCTest
@testable import EJWhatShouldIWear

class EJConvertHelperTests: XCTestCase {
    
    var sut: EJConvertHelper!
    
    override func setUp() {
        super.setUp()
        sut = EJConvertHelper()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func testConvert_giveCoordinate_toGrid() {
        let expectedGridX = 62
        let expectedGridY = 125
        
        let lat: Double = 37.503417959999986
        let lon: Double = 127.11669920999995
        let grid = sut.convertGRID_GPS(mode: .TO_GRID, latitude: lat, longitude: lon)
        
        XCTAssertEqual(expectedGridX, grid.X)
        XCTAssertEqual(expectedGridY, grid.Y)
    }

}
