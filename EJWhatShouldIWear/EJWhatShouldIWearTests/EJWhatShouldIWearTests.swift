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
    
    func testParsingJSONDistrict() {
        let decoder = JSONDecoder()
        
        if let path = Bundle.main.path(forResource: "korea-district", ofType: "json") {
            if let contents = try? String(contentsOfFile: path) {
                if let data = contents.data(using: .utf8) {
                    if let myDistrict = try? decoder.decode(MyDistrict.self, from: data) {
                        print(myDistrict.data)
                        let city = "울산광역시"
                        XCTAssertEqual(myDistrict.data[city], ["중구", "남구", "동구", "북구", "울주군"])
                    }
                }
            }
        }
    }
}

class MyDistrict: Decodable {
    var name: String
    var version: String
    var url: String
    var data: Dictionary<String, Array<String>>
}

