//
//  EJNewHomeViewModel.swift
//  EJWhatShouldIWear
//
//  Created by chungeunji on 2020/04/19.
//  Copyright © 2020 DEV_MOBILE_IOS_JUNIOR. All rights reserved.
//

import Foundation
import CoreLocation

final class EJNewHomeViewModel {
    
    // MARK: - Properties
    var weatherInfo: [EJFiveDaysList]?
    var FiveDaysWeatherList: [EJFiveDaysList]?
    var FiveDaysWeatherModel: EJFiveDaysWeatherModel?
    var threedaysModel: [EJThreedaysForecastModel] = []
    var sixdaysModel: [EJSixdaysForecastModel] = []
    
    // MARK: - Closures
    var didSetLocationInfoSuccessClosure: ((String) -> Void)?
    var didSetLocationInfoFailureClosure: ((String) -> Void)?
    var didRequestKoreaWeatherInfoSuccessClosure: (() -> Void)?
    var didRequestKoreaWeatherInfoFailureClosure: ((Error) -> Void)?
    var didRequestWeatherInfo: ((Int) -> Void)?
    var didrequestForeignWeatherInfoSuccessClosure: (() -> Void)?
    var didrequestForeignWeatherInfoFailureClosure: ((Error) -> Void)?
    
    // MARK: - Public Methods
    func setMyLocationLabel(of currentLocation: CLLocation) {
        EJLocationManager.shared.getLocation(of: currentLocation, success: { country, result in
            if result != "" {
                self.didSetLocationInfoSuccessClosure?(result)
            } else {
                self.didSetLocationInfoFailureClosure?("Unknown locality. Please refresh the view.")
            }
        }) { error in
            self.didSetLocationInfoFailureClosure?(error.localizedDescription)
        }
    }
    
    func requestKoreaWeather(_ index: Int) {
        callWeatherInfo(index, success: {
            self.didRequestKoreaWeatherInfoSuccessClosure?()
        }) { error in
            self.didRequestKoreaWeatherInfoFailureClosure?(error)
        }
    }
    
    private func requestFiveDaysWeatherList(of current: CLLocation) {
        owmFiveDaysWeatherInfo(success: { result in
            let fivedaysWeather = EJFiveDaysWeatherModel.init(object: result)
            self.FiveDaysWeatherModel = fivedaysWeather
            self.FiveDaysWeatherList = fivedaysWeather.list
            self.didrequestForeignWeatherInfoSuccessClosure?()
        }) { error in
            self.didrequestForeignWeatherInfoFailureClosure?(error)
        }
    }
    
    // MARK: - HTTP Request
    func owmFiveDaysWeatherInfo(success: @escaping SuccessHandler,
                                failure: @escaping FailureHandler) {
        let longitude = EJLocationManager.shared.longitude
        let latitude = EJLocationManager.shared.latitude
        let url = owmAPIPath + "forecast?lat=\(latitude)&lon=\(longitude)&apiKey=\(owmAppKey)"
        EJHTTPClient().weatherRequest(url: url,
                                      success: success,
                                      failure: failure)
        
    }
    
    private func skwpSixDaysWeatherInfo(_ index: Int, success: @escaping ([EJSixdaysForecastModel]) -> (),
                                        failure: @escaping FailureHandler) {
        let longitude = EJLocationManager.shared.longitude
        let latitude = EJLocationManager.shared.latitude
        let url = skWPSixDaysAPI + "?appKey=\(skPublicAppKey[index])&lat=\(latitude)&lon=\(longitude)"
        EJHTTPClient().weatherRequest(url: url,
                                      success: { resultData in
                                        guard let data = resultData else {
                                            self.didRequestWeatherInfo?(index+1)
                                            return
                                        }
                                        
                                        do {
                                            let sixdaysModel = try JSONDecoder().decode(EJWeatherBaseModel.self, from: data)
                                            if let sixdaysForecastModel = sixdaysModel.weather.forecast6days {
                                                success(sixdaysForecastModel)
                                            }
                                        } catch {
                                            failure(error)
                                        }
        }, failure: failure)
    }
    
    private func skwpThreeDaysWeatherInfo(_ index: Int, success: @escaping ([EJThreedaysForecastModel]) -> (),
                                          failure: @escaping FailureHandler) {
        let longitude = EJLocationManager.shared.longitude
        let latitude = EJLocationManager.shared.latitude
        let url = skWPThreeDaysAPI + "?appKey=\(skPublicAppKey[index])&lat=\(latitude)&lon=\(longitude)"
        EJHTTPClient().weatherRequest(url: url,
                                      success: { resultData in
                                        guard let data = resultData else {
                                            self.didRequestWeatherInfo?(index+1)
                                            return
                                        }
                                        
                                        do {
                                            let threedaysModel = try JSONDecoder().decode(EJWeatherBaseModel.self, from: data)
                                            if let threedaysForecastModel = threedaysModel.weather.forecast3days {
                                                success(threedaysForecastModel)
                                            }
                                        } catch {
                                            failure(error)
                                        }
        }, failure: failure)
    }
    
    public func callWeatherInfo(_ index: Int,
                                success: @escaping () -> (),
                                failure: @escaping FailureHandler) {
        var threeDaysWeather: [EJThreedaysForecastModel] = []
        var sixDaysWeather: [EJSixdaysForecastModel] = []
        var resultError: Error?
        EJLogger.d("=============== Dispatch Group ===== START! ==============")
        
        let dispatchGroup = DispatchGroup()
        let dispatchQueue = DispatchQueue.global()
        
        dispatchGroup.enter()
        dispatchQueue.async {
            self.skwpThreeDaysWeatherInfo(index,
                                          success: { result in
                                            threeDaysWeather = result
                                            dispatchGroup.leave()
            }) { (error) in
                resultError = error
                dispatchGroup.leave()
            }
        }
        
        dispatchGroup.enter()
        dispatchQueue.async {
            self.skwpSixDaysWeatherInfo(index,
                                        success: { result in
                                            sixDaysWeather = result
                                            dispatchGroup.leave()
            }) { (error) in
                resultError = error
                dispatchGroup.leave()
            }
        }
        
        dispatchGroup.notify(queue: .main) {
            EJLogger.d("=============== Dispatch Group ===== Done! ==============")
            if let error = resultError {
                failure(error)
            } else {
                self.threedaysModel = threeDaysWeather
                self.sixdaysModel = sixDaysWeather
            }
        }
    }
}
