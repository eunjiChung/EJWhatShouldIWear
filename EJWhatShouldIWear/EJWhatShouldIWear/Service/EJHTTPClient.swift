//
//  EJHTTPClient.swift
//  EJWhatShouldIWear
//
//  Created by DEV_MOBILE_IOS_JUNIOR on 21/05/2019.
//  Copyright © 2019 DEV_MOBILE_IOS_JUNIOR. All rights reserved.
//

import Alamofire
import Moya

enum ResponseCode: Int, Codable {
    case success = 200
}

struct EJNetworkAdapter {

    enum ResponseType: String, Codable {
        case success
    }

    struct Error: Codable {
        var code: Int?
        var message: String?
//        var meta: EJResponseMeta?
    }

    struct EJResponseMeta: Codable {
        var description: String?
    }

    // SSL 설정 참고 : https://github.com/Moya/Moya/issues/992
    static let provider = MoyaProvider<MultiTarget>(plugins: [NetworkLoggerPlugin(configuration: NetworkLoggerPlugin.Configuration(logOptions: .verbose))])

    @discardableResult
    static func request<T: TargetType>(target: T,
                                       success successCallback: @escaping (Response) -> Void,
                                       progress progressCallback: ((ProgressResponse) -> Void)? = nil,
                                       error errorCallback: @escaping (Swift.Error) -> Void,
                                       failure failureCallback: @escaping (MoyaError) -> Void) -> Cancellable {
        let cancellable = provider.request(MultiTarget(target), progress: { (progress) in
               progressCallback?(progress)
        }, completion: { (result) in
            switch result {
            case .success(let response):
                self.printCurl(for: target, request: response.request)

                if response.statusCode >= 200 && response.statusCode <= 300 {
                    successCallback(response)
                } else {
                    // 에러처리
                }
            case .failure(let error):
                self.printCurl(for: target, request: error.response?.request)
                failureCallback(error)
            }
        })

        return cancellable
    }

    private static func printCurl(for target: TargetType, request: URLRequest?) {
        #if DEBUG
        guard let request = request else { return }
        let message: String = "\ntarget: \(target)\n"
        #endif
    }
}

final class EJHTTPClient: NSObject {

    func weatherRequest(url: String,
                        success: @escaping (Data?) -> (),
                        failure: @escaping (Error) -> ()) {
        guard let result = URL(string: url) else { fatalError() }
        AF.request(result).responseJSON { response in
            switch response.result {
            case .success(let model):
                let jsonModel = model as! [String: Any]
                if let error = jsonModel["error"] {
                    let errorJSON = error as! [String: Any]
                    let code = errorJSON["code"] as! String
                    if code == "8102" {
                        success(nil)
                    }
                } else {
                    if let data = response.data {
                        success(data)
                    } else {
                        success(nil)
                    }
                }
            case .failure(let error):
                failure(error)
            }
        }
    }
}
