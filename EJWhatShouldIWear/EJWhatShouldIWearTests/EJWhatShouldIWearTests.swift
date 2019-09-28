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
        print("=================== START ====================")
        
        group.notify(queue: queue) {
            print("====================================== Done!")
        }
        
        
        fetchThree()
        fetchSix()
        
    }
    
    func fetchThree() {
        
        queue.async(group: group) {
            guard let url = URL(string: skWPThreeDaysAPI+"?appKey=\(skDebugAppKey)&lat=\(37.51151)&lon=\(127.0967)") else { return }
            
            Alamofire.request(url).responseJSON { (response) in
                print("Entering Group33333333333")
                if response.result.isSuccess {
                    if let result = response.result.value as? [String: Any] {
                        print("3 Days Result: \(result)")
                    }
                } else {
                    if let error = response.result.error {
                        print("\(error.localizedDescription)")
                    }
                }
            }
        }
        
    }
    
    func fetchSix() {
        queue.async(group: group) {
            guard let url = URL(string: skWPSixDaysAPI+"?appKey=\(skDebugAppKey)&lat=\(37.51151)&lon=\(127.0967)") else { return }
            
            Alamofire.request(url).responseJSON { (response) in
                print("Entering Group6666666666")
                if response.result.isSuccess {
                    if let result = response.result.value as? [String: Any] {
                        print("6 Days Result: \(result)")
                    }
                } else {
                    if let error = response.result.error {
                        print("\(error.localizedDescription)")
                    }
                }
            }
        }
        
    }
    
}
