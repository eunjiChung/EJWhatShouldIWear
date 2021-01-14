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
    case mallSection
    case timelyWeatherSection
    case weekelyWeatherSection
    case admobSection
    case dummySection
}

enum EJShowClothRowType: Int, CaseIterable {
    case closeClothsCell = 0, showClothsCell
}

final class EJHomeViewModel {
    // MARK: - Properties
    var weatherInfo: [EJFiveDaysList]?
    var FiveDaysWeatherList: [EJFiveDaysList]?
    var FiveDaysWeatherModel: EJFiveDaysWeatherModel?
    
    // MARK: - Kisangchung Models
    var kisangTimeModel: [EJKisangTimeModel]?
    var kisangWeekelyModel: (date: String, model: [EJWeekelyCellModel]) = ("", model: [])
    var kisangForecastModel: [EJKisangWeekForecastModel]?
    var clothItems: [EJItemModel]?
    
    // MARK: - Closures
    var didrequestForeignWeatherInfoSuccessClosure: (() -> Void)?
    var didrequestForeignWeatherInfoFailureClosure: ((Error) -> Void)?
    
    // MARK: - Kisangchung's Closures
    var didRequestKisangWeatherInfoSuccessClosure: (()->Void)?
    var didRequestKisangWeatherInfoFailureClosure: ((String)->Void)?
    
    
    // MARK: - Public Methods

    // TODO: - 이 많은 그룹을 어떻게 정리할 지,...강의 듣기
    let weatherQueue = DispatchQueue(label: "weather info request", qos: .background, attributes: .concurrent)
    let weatherGroup = DispatchGroup()

    let clothQueue = DispatchQueue(label: "cloth info request", qos: .background, attributes: .concurrent)
    let clothGroup = DispatchGroup()

    func requestMainInfo() {
        weatherGroup.enter()
        requestKoreaWeather()
        weatherGroup.notify(queue: weatherQueue) {
            self.clothGroup.enter()
            let level = EJWeatherManager.generateAverageTemp(self.kisangTimeModel) // enter하는 시점에는 kisanTimeModel이 없다...finish된 후에 비로소 가능 -> request를 한번에 보내는게 아니라, 한 개가 끝나서 finish가 찍혀야 requestLook을 해줘야 한다
            EJMallManager.shared.requestLook(level) {
                self.clothQueue.async(group: self.clothGroup) {
                    self.clothGroup.leave()
                }
            }
            self.clothGroup.notify(queue: self.clothQueue) {
                self.pickRandomItems()
                self.didRequestKisangWeatherInfoSuccessClosure?()
            }
        }
    }

    private func pickRandomItems() {
        var items: [EJItemModel] = []
        let stores = EJMallManager.shared.stores
        for store in stores {
            let shuffled = store.items?.shuffled()
            let choosed = shuffled?[randomPick: 3]
            choosed?.forEach({ items.append($0) })
        }
        clothItems = items.shuffled()
    }

    private func finishRequest() {
        weatherQueue.async(group: weatherGroup) {
            self.weatherGroup.leave()
        }
    }

    func requestWeather() {
        if EJLocationManager.shared.isKorea {
            requestWeatherDispatchGroup()
        } else {
            requestFiveDaysWeatherList()
        }
    }

    func requestWeatherDispatchGroup() {
        var resultError: String?
        EJLogger.d("=============== Dispatch Group 2 ===== START! ==============")

        let dispatchGroup = DispatchGroup()
        let dispatchQueue = DispatchQueue.global()

        dispatchGroup.enter()
        dispatchQueue.async {
            self.requestCashingTodayWeather {
                dispatchGroup.leave()
            } failure: { errorMsg in
                resultError = errorMsg
                return
            }
        }
        dispatchGroup.enter()
        dispatchQueue.async {
            self.requestCashingWeekelyWeather {
                dispatchGroup.leave()
            } failure: { errorMsg in
                resultError = errorMsg
                return
            }
        }

        dispatchGroup.notify(queue: .main) {
            EJLogger.d("=============== Dispatch Group 2===== Done! ==============")
            if let error = resultError {
                self.didRequestKisangWeatherInfoFailureClosure?(error)
            } else {
                self.didRequestKisangWeatherInfoSuccessClosure?()
            }
        }

    }

    func requestCashingTodayWeather(success: @escaping () -> Void,
                                    failure: @escaping (String) -> Void) {
        EJNetworkAdapter.request(target: EJWeatherAPI.today(nx: 62, ny: 125)) { response in
            do {
                let model = try JSONDecoder().decode(EJKisangTimelyBaseModel.self, from: response.data)
                if let resultCode = EJKisangStatusCode(rawValue: model.response.header.resultCode.code) {
                    switch resultCode {
                    case .NORMAL_SERVICE:
                        self.kisangTimeModel = self.generateTimeModels(model.response.body)
                        success()
                    default:
                        self.requestKoreaWeather()
                        failure(model.response.header.resultCode.message)
                    }
                }
            } catch {
                self.requestKoreaWeather()
            }
        } error: { error in
            self.requestKoreaWeather()
        } failure: { failError in
            self.requestKoreaWeather()
        }
    }

    func requestCashingWeekelyWeather(success: @escaping () -> Void,
                                      failure: @escaping (String) -> Void) {
        let regionId = EJLocationManager.shared.regionCode
        EJNetworkAdapter.request(target: EJWeatherAPI.weekly(regionId: regionId)) { response in
            do {
                let model = try JSONDecoder().decode(EJKisangWeekelyBaseModel.self, from: response.data)
                let resultCode = model.response.header.resultCode
                switch resultCode {
                case .NORMAL_SERVICE:
                    self.kisangWeekelyModel.model = self.generateWeekModel(model.response.body.items.item)
                    print("❤️일주일 모델:", self.kisangWeekelyModel)
                    success()
                default:
                    failure(resultCode.message)
                }
            } catch {
                self.requestKoreaWeather()
            }
        } error: { error in
            self.requestKoreaWeather()
        } failure: { failError in
            self.requestKoreaWeather()
        }
    }

    func requestKoreaWeather() {
        callKisangWeatherInfo(success: {
//            self.didRequestKisangWeatherInfoSuccessClosure?()
            self.finishRequest()
        }) { error in
            self.didRequestKisangWeatherInfoFailureClosure?(error.localizedDescription)
        }
    }
    
    func requestFiveDaysWeatherList() {
//        EJNetworkAdapter.request(target: EJForeignWeatherAPI.fiveDaysWeather) { response in
//            do {
//                let model = try JSONDecoder().decode(EJFiveDaysWeatherModel.self, from: response.data)
//                print("❤️", model)
//            } catch {
//                EJLogger.e(error.localizedDescription)
//            }
//        } error: { error in
//            EJLogger.e(error.localizedDescription)
//        } failure: { failError in
//            EJLogger.e(failError.localizedDescription)
//        }
        owmFiveDaysWeatherInfo(success: { result in
            let fivedaysWeather = EJFiveDaysWeatherModel.init(object: result)
            self.FiveDaysWeatherModel = fivedaysWeather
            self.FiveDaysWeatherList = fivedaysWeather.list
            self.didrequestForeignWeatherInfoSuccessClosure?()
        }) { error in
            self.didrequestForeignWeatherInfoFailureClosure?(error)
        }
    }
}

// MARK: - KiSangChung Networking
// TODO: - DispatchGroup에서 배열을 closure안에서 저장하면 호출이 안된다...왜?
extension EJHomeViewModel {
    
    public func callKisangWeatherInfo(success: @escaping () -> Void,
                                      failure: @escaping FailureHandler) {
        var resultError: Error?
        EJLogger.d("=============== Dispatch Group ===== START! ==============")
        
        let dispatchGroup = DispatchGroup()
        let dispatchQueue = DispatchQueue.global()
        
        dispatchGroup.enter()
        dispatchQueue.async {
            self.kisangTimelyWeather(success: { model in
                if model.response.header.resultCode.code == EJKisangStatusCode.NORMAL_SERVICE.rawValue {
                    self.kisangTimeModel = self.generateTimeModels(model.response.body)
                    dispatchGroup.leave()
                } else {
                    let errorMsg = model.response.header.resultCode.message
                    self.didRequestKisangWeatherInfoFailureClosure?(errorMsg)
                    return
                }
            }, failure: { error in
                resultError = error
                dispatchGroup.leave()
            })
        }
        
        dispatchGroup.enter()
        dispatchQueue.async {
            self.kisangWeekelyWeather(success: { model in
                if model.response.header.resultCode.rawValue == "00" {
                    self.kisangWeekelyModel.model = self.generateWeekModel(model.response.body.items.item)
                    dispatchGroup.leave()
                } else {
                    let errorMsg = model.response.header.resultCode.message
                    self.didRequestKisangWeatherInfoFailureClosure?(errorMsg)
                    return
                }
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
    // TODO: - BaseDate(), BaseTime() 제대로 넣어주기
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

    /// 날짜와 시간이 category에 따라 여러개 내려오기 때문에
    /// 날짜와 시간이 달라질 때 resultModel에 append해주고 나머지 값들을 nil처리 해준다
    private func generateTimeModels(_ body: EJKisangTimelyBodyModel) -> [EJKisangTimeModel]? {
        let items = body.items.item
        var resultModels: [EJKisangTimeModel] = []

        guard var date = items.first?.fcstDate, var time = items.first?.fcstTime else { return [] }
        var weatherCode: WeatherCode?
        var temperature: Int?
        for item in items {
            if item.fcstDate != date || item.fcstTime != time {
                if let code = weatherCode, let temp = temperature {
                    resultModels.append(EJKisangTimeModel(fcstDate: date, fcstTime: time, temperature: temp, weatherCode: code))
                    weatherCode = nil
                    temperature = nil
                }
                date = item.fcstDate
                time = item.fcstTime
            }
            
            if let value = Int(item.fcstValue) {
                switch item.category {
                case .rainFallType:
                    if let code = EJPrecipitationCode(rawValue: value), code != .no { weatherCode = code }
                case .skyCode:
                    if let code = EJSkyCode(rawValue: value), weatherCode == nil { weatherCode = code }
                case .threeHourTemp:
                    temperature = value
                default:
                    EJLogger.d("")
                }
            }
        }

        return resultModels
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

// MARK: - Foreign API Call
extension EJHomeViewModel {
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
