//
//  EJWhatShouldIWearTests.swift
//  EJWhatShouldIWearTests
//
//  Created by CHUNGEUNJI on 11/07/2019.
//  Copyright © 2019 DEV_MOBILE_IOS_JUNIOR. All rights reserved.
//


import XCTest
import Firebase
import Alamofire
@testable import EJWhatShouldIWear

class EJWhatShouldIWearTests: XCTestCase {
    
    var sut: EJWeatherManager!
    var weatherClass : WeatherMain!
    var http: EJHTTPClient!
    let networkStub = HTTPMock()
    let group = DispatchGroup()
    let queue = DispatchQueue(label: "test", attributes: .concurrent)
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        super.setUp()
        sut = EJWeatherManager()
        http = EJHTTPClient()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        sut = nil
        super.tearDown()
    }
    
    func testGeneratingWeatherDescription() {
        // 1. 날씨 정보 받아오기
        if let sky = networkStub.getSky() {
            XCTAssertEqual(sky.code4hour, "SKY_S11")
            // 2. 가장 심각한 날씨 정보 가져오기
            let criticCondition = sut.pickCriticWeather(sky)
            // 3. 개중에 가장 심각한 날씨 정보를 제대로 가져오는지 확인
            XCTAssertEqual(criticCondition, .cloud)
        }
    }
    
    
    
    
}

