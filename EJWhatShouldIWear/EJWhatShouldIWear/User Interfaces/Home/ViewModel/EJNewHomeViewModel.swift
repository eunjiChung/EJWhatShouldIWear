//
//  EJNewHomeViewModel.swift
//  EJWhatShouldIWear
//
//  Created by chungeunji on 2020/04/19.
//  Copyright © 2020 DEV_MOBILE_IOS_JUNIOR. All rights reserved.
//

import Foundation

enum EJHomeSectionType: Int, CaseIterable {
    case showClothSection       = 0
    case timelyWeatherSection
    case weekelyWeatherSection
    case admobSection
    case dummySection
}

enum EJShowClothRowType: Int, CaseIterable {
    case closeClothsCell = 0, showClothsCell
}

final class EJNewHomeViewModel {
    // MARK: - Properties
    var weatherInfo: [EJFiveDaysList]?
    var FiveDaysWeatherList: [EJFiveDaysList]?
    var FiveDaysWeatherModel: EJFiveDaysWeatherModel?
    var threedaysModel: [EJThreedaysForecastModel]?
    var sixdaysModel: [EJSixdaysForecastModel]?
    
    // MARK: - Kisangchung Models
    var kisangTimeModel: [EJKisangTimeModel]?
    var kisangWeekelyModel: (date: String, model: [EJWeekelyCellModel]) = ("", model: [])
    var kisangForecastModel: [EJKisangWeekForecastModel]?
    
    // MARK: - Closures
    var didRequestKoreaWeatherInfoSuccessClosure: (() -> Void)?
    var didRequestKoreaWeatherInfoFailureClosure: ((Error) -> Void)?
    var didRequestWeatherInfo: ((Int) -> Void)?
    var didrequestForeignWeatherInfoSuccessClosure: (() -> Void)?
    var didrequestForeignWeatherInfoFailureClosure: ((Error) -> Void)?
    
    // MARK: - Kisangchung's Closures
    var didRequestKisangWeatherInfoSuccessClosure: (()->Void)?
    var didRequestKisangWeatherInfoFailureClosure: ((Error)->Void)?
    
    
    // MARK: - Public Methods
    func requestKoreaWeather(_ index: Int) {
        callKisangWeatherInfo(success: {
            self.didRequestKisangWeatherInfoSuccessClosure?()
        }) { error in
            self.didRequestKisangWeatherInfoFailureClosure?(error)
        }
    }
    
    func requestFiveDaysWeatherList() {
        owmFiveDaysWeatherInfo(success: { result in
            let fivedaysWeather = EJFiveDaysWeatherModel.init(object: result)
            self.FiveDaysWeatherModel = fivedaysWeather
            self.FiveDaysWeatherList = fivedaysWeather.list
            self.didrequestForeignWeatherInfoSuccessClosure?()
        }) { error in
            self.didrequestForeignWeatherInfoFailureClosure?(error)
        }
    }
    
    public func callWeatherInfo(_ index: Int,
                                success: @escaping () -> Void,
                                failure: @escaping FailureHandler) {
        // TODO: - DispatchGroup에서 배열을 closure안에서 저장하면 호출이 안된다...왜?
        var resultError: Error?
        EJLogger.d("=============== Dispatch Group ===== START! ==============")
        
        let dispatchGroup = DispatchGroup()
        let dispatchQueue = DispatchQueue.global()
        
        dispatchGroup.enter()
        dispatchQueue.async {
            self.skwpThreeDaysWeatherInfo(index,
                                          success: { three in
                                            guard let fcst3dayModel = three.weather.forecast3days else { return }
                                            self.threedaysModel = fcst3dayModel
                                            dispatchGroup.leave()
            }) { (error) in
                resultError = error
                dispatchGroup.leave()
            }
        }
        
        dispatchGroup.enter()
        dispatchQueue.async {
            self.skwpSixDaysWeatherInfo(index,
                                        success: { six in
                                            guard let fcstModel6dayModel = six.weather.forecast6days else { return }
                                            self.sixdaysModel = fcstModel6dayModel
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
                success()
            }
        }
    }
}

// MARK: - KiSangChung Networking
// TODO: - 네트워킹 코드 모야 라이브러리처럼 줄이기!
extension EJNewHomeViewModel {
    
    public func callKisangWeatherInfo(success: @escaping () -> Void,
                                      failure: @escaping FailureHandler) {
        var resultError: Error?
        EJLogger.d("=============== Dispatch Group ===== START! ==============")
        
        let dispatchGroup = DispatchGroup()
        let dispatchQueue = DispatchQueue.global()
        
        dispatchGroup.enter()
        dispatchQueue.async {
            self.kisangTimelyWeather(success: { model in
                self.kisangTimeModel = self.generateTimeModels(model.response.body.items.item)
                dispatchGroup.leave()
            }, failure: { error in
                resultError = error
                dispatchGroup.leave()
            })
        }
        
        dispatchGroup.enter()
        dispatchQueue.async {
            self.kisangWeekelyWeather(success: { model in
                self.kisangWeekelyModel.model = self.generateWeekModel(model.response.body.items.item)
                dispatchGroup.leave()
            }, failure: { error in
                resultError = error
                dispatchGroup.leave()
            })
        }
        
        dispatchGroup.notify(queue: .main) {
            EJLogger.d("=============== Dispatch Group ===== Done! ==============")
            if let error = resultError {
                failure(error)
            } else {
                success()
            }
        }
    }
    
    // TODO: - 에러코드에 따라서 에러처리 해주기!!!
    func kisangTimelyWeather(success: @escaping (EJKisangTimelyBaseModel) -> (), failure: @escaping FailureHandler) {
        let baseDate = EJKisangInfoManager().generateBaseDate()
        let baseTime = EJKisangInfoManager().generateBaseTime()
        let gridX = EJLocationManager.shared.grid.X
        let gridY = EJLocationManager.shared.grid.Y
        let url = kisangBaseAPI + kisangTimelyAPI + "?serviceKey=\(kisangAppKey)&pageNo=1&numOfRows=225&dataType=JSON&base_date=\(baseDate)&base_time=\(baseTime)&nx=\(gridX)&ny=\(gridY)"
        
        EJHTTPClient().weatherRequest(url: url, success: { result in
            do {
                guard let data = result else { return }
                let model = try JSONDecoder().decode(EJKisangTimelyBaseModel.self, from: data)
                success(model)
            } catch {
                failure(error)
            }
        }) { error in
            failure(error)
        }
    }
    
    func kisangWeekelyWeather(success: @escaping (EJKisangWeekelyBaseModel) -> (), failure: @escaping FailureHandler) {
        let regId = EJLocationManager.shared.regionCode
        let baseTime = EJKisangInfoManager().weekelyForecastTime()
        let url = kisangBaseAPI + kisangWeekelyAPI + "?serviceKey=\(kisangAppKey)&pageNo=1&numOfRows=10&dataType=JSON&regId=\(regId)&tmFc=\(baseTime)"
        kisangWeekelyModel.date = baseTime
        
        EJHTTPClient().weatherRequest(url: url, success: { result in
            do {
                guard let data = result else { return }
                let model = try JSONDecoder().decode(EJKisangWeekelyBaseModel.self, from: data)
                success(model)
            } catch {
                failure(error)
            }
        }) { error in
            failure(error)
        }
    }
    
    private func generateTimeModels(_ item: [EJKisangTimelyModel]) -> [EJKisangTimeModel]? {
        var tempModels: [EJKisangTimeModel] = []
        guard var date = item.first?.fcstDate, var time = item.first?.fcstTime else { return [] }
        
        var skyCode: EJSkyCode?
        var rainyCode: EJPrecipitationCode?
        var temperature: Int?
        for model in item {
            if model.fcstDate != date {
                if let sky = skyCode, let rainy = rainyCode, let temp = temperature {
                    tempModels.append(EJKisangTimeModel(fcstDate: date, fcstTime: time, temperature: temp, skyCode: sky, rainyCode: rainy))
                    skyCode = nil
                    rainyCode = nil
                    temperature = nil
                }
                date = model.fcstDate
            }
            if model.fcstTime != time {
                if let sky = skyCode, let rainy = rainyCode, let temp = temperature {
                    tempModels.append(EJKisangTimeModel(fcstDate: date, fcstTime: time, temperature: temp, skyCode: sky, rainyCode: rainy))
                    skyCode = nil
                    rainyCode = nil
                    temperature = nil
                }
                time = model.fcstTime
            }
            
            if let value = Int(model.fcstValue) {
                switch model.category {
                case .skyCode:
                    if let code = EJSkyCode(rawValue: value) { skyCode = code }
                case .rainFallType:
                    if let code = EJPrecipitationCode(rawValue: value) { rainyCode = code }
                case .threeHourTemp:
                    temperature = value
                default:
                    EJLogger.d("")
                }
            }
        }
        
        return tempModels
    }
    
    func generateWeekModel(_ model: [EJKisangWeekelyItemModel]) -> [EJWeekelyCellModel] {
        guard let model = model.first else { return [] }
        var array: [EJWeekelyCellModel] = []
        array.append(EJWeekelyCellModel(maxTemp: model.taMax3, minTemp: model.taMin3))
        array.append(EJWeekelyCellModel(maxTemp: model.taMax4, minTemp: model.taMin4))
        array.append(EJWeekelyCellModel(maxTemp: model.taMax5, minTemp: model.taMin5))
        array.append(EJWeekelyCellModel(maxTemp: model.taMax6, minTemp: model.taMin6))
        array.append(EJWeekelyCellModel(maxTemp: model.taMax7, minTemp: model.taMin7))
        array.append(EJWeekelyCellModel(maxTemp: model.taMax8, minTemp: model.taMin8))
        array.append(EJWeekelyCellModel(maxTemp: model.taMax9, minTemp: model.taMin9))
        return array
    }
}

// MARK: - SK Weather Planet API
extension EJNewHomeViewModel {
    private func skwpSixDaysWeatherInfo(_ index: Int, success: @escaping (EJSixdaysWeatherBaseModel) -> (),
                                        failure: @escaping FailureHandler) {
        let longitude = EJLocationManager.shared.longitude
        let latitude = EJLocationManager.shared.latitude
        let url = skWPSixDaysAPI + "?appKey=\(skAppKeys[index])&lat=\(latitude)&lon=\(longitude)"
        EJHTTPClient().weatherRequest(url: url,
                                      success: { resultData in
                                        guard let data = resultData else {
                                            self.didRequestWeatherInfo?(index+1)
                                            return
                                        }
                                        
                                        do {
                                            let sixdaysModel = try JSONDecoder().decode(EJSixdaysWeatherBaseModel.self, from: data)
                                            success(sixdaysModel)
                                        } catch {
                                            failure(error)
                                        }
        }, failure: failure)
    }
    
    private func skwpThreeDaysWeatherInfo(_ index: Int, success: @escaping (EJThreedaysWeatherBaseModel) -> (),
                                          failure: @escaping FailureHandler) {
        let longitude = EJLocationManager.shared.longitude
        let latitude = EJLocationManager.shared.latitude
        let url = skWPThreeDaysAPI + "?appKey=\(skAppKeys[index])&lat=\(latitude)&lon=\(longitude)"
        EJHTTPClient().weatherRequest(url: url,
                                      success: { resultData in
                                        guard let data = resultData else {
                                            self.didRequestWeatherInfo?(index+1)
                                            return
                                        }
                                        
                                        do {
                                            let threedaysModel = try JSONDecoder().decode(EJThreedaysWeatherBaseModel.self, from: data)
                                            success(threedaysModel)
                                        } catch {
                                            failure(error)
                                        }
        }, failure: failure)
    }
}

// MARK: - Foreign API Call
extension EJNewHomeViewModel {
    func owmFiveDaysWeatherInfo(success: @escaping SuccessHandler,
                                failure: @escaping FailureHandler) {
        let longitude = EJLocationManager.shared.longitude
        let latitude = EJLocationManager.shared.latitude
        let url = owmAPIPath + "forecast?lat=\(latitude)&lon=\(longitude)&apiKey=\(owmAppKey)"
        EJHTTPClient().weatherRequest(url: url,
                                      success: success,
                                      failure: failure)
    }
}
