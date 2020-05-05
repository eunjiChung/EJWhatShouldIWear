//
//  EJLocationManagerTests.swift
//  EJWhatShouldIWearTests
//
//  Created by chungeunji on 2020/05/05.
//  Copyright © 2020 DEV_MOBILE_IOS_JUNIOR. All rights reserved.
//

import XCTest
import EJWhatShouldIWear

class EJLocationManagerTests: XCTestCase {
    
    var sut: EJLocationManager!

    override func setUpWithError() throws {
        super.setUp()
        sut = EJLocationManager()
    }

    override func tearDownWithError() throws {
        sut = nil
        super.tearDown()
    }
    
    
    func testGeo_convertAddressToCLLocationDegrees() {
        sut.convertToAddressWith()
    }
    
}
