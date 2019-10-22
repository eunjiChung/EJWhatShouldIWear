//
//  EJHTTPClient.swift
//  EJWhatShouldIWear
//
//  Created by DEV_MOBILE_IOS_JUNIOR on 21/05/2019.
//  Copyright © 2019 DEV_MOBILE_IOS_JUNIOR. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class EJHTTPClient: NSObject {
    
    // MARK: - Initialize
    override init() {
        super.init()
    }
    
    // MARK: - Alamofire
    func weatherRequest(url: String,
                        lat:Double,
                        lon:Double,
                      success: @escaping ([String: Any]) -> (),
                      failure: @escaping (Error) -> ()) {
    
        guard let result = URL(string: url) else {
            fatalError()
        }
        
        Alamofire.request(result).responseJSON { (response) in
                       
            print("==============================================1")
            
            if response.result.isSuccess
            {

                print("==============================================3")
                if let result = response.result.value as? [String: Any]
                {
                    print("==============================================2")
                    success(result)
                }
                
            } else {
                print("==============================================4")
                if let error = response.result.error {
                    print("==============================================Error")
                    failure(error)
                }
            }
        }
    }

}
