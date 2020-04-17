//
//  EJHTTPClient.swift
//  EJWhatShouldIWear
//
//  Created by DEV_MOBILE_IOS_JUNIOR on 21/05/2019.
//  Copyright © 2019 DEV_MOBILE_IOS_JUNIOR. All rights reserved.
//

import Alamofire

typealias JSONType = [String: Any]

class EJHTTPClient: NSObject {
    // MARK: - Networking
    func weatherRequest(url: String,
                        success: @escaping (JSONType) -> (),
                        failure: @escaping (Error) -> ()) {
        guard let result = URL(string: url) else { fatalError() }
        
        Alamofire.request(result).responseJSON { response in
            switch response.result {
            case .success(let model):
                success(model as! JSONType)
            case .failure(let error):
                failure(error)
            }
        }
    }

}
