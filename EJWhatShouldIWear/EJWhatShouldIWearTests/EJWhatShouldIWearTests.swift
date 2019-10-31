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
    var http: EJHTTPClient!
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
    
    func testDispatchGroup() {
        // Alamofire가 unit test에서 작동을 잘 안했다
        
    }
    
    
}

