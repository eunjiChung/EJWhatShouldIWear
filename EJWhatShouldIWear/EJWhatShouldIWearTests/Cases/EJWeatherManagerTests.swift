//
//  EJWeatherManagerTests.swift
//  EJWhatShouldIWearTests
//
//  Created by CHUNGEUNJI on 05/03/2020.
//  Copyright © 2020 DEV_MOBILE_IOS_JUNIOR. All rights reserved.
//

import XCTest
@testable import EJWhatShouldIWear

class EJWeatherManagerTests: XCTestCase {

    var sut: EJWeatherManager!
    
    override func setUp() {
        super.setUp()
        sut = EJWeatherManager()
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func test_getWeatherJSON_generateWeatherMain() throws {
        // given
        let data = try Data.fromJSON(fileName: "Data_Forecast3days_response")
        let decoder = JSONDecoder()
        let result = try decoder.decode(<#T##type: Decodable.Protocol##Decodable.Protocol#>, from: <#T##Data#>)
        // when
        // then
    }
    

}
