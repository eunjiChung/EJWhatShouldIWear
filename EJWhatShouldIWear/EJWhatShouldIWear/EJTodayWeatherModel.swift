//
//  EJTodayWeatherModel.swift
//  EJWhatShouldIWear
//
//  Created by chungeunji on 2020/06/01.
//  Copyright © 2020 DEV_MOBILE_IOS_JUNIOR. All rights reserved.
//

import Foundation

final class EJTodayWeatherModel: NSObject {
    
    static let shared = EJTodayWeatherModel()
    
    // 오늘 기온
    var temperature: Int?
    // 오늘 하늘 상태
    var sky: EJSkyCode?
    // 오늘 강수
    var rainfall: EJPrecipitationCode?
    // 오늘 풍속
    var windy: Int?
    // 오늘 옷차림
    var dress: String?
    
//    init(temperature: Int,
//         sky: EJSkyCode,
//         rainfall: EJPrecipitationCode,
//         windy: Int,
//         dress: String) {
//        self.temperature = temperature
//        self.sky = sky
//        self.rainfall = rainfall
//        self.windy = windy
//        self.dress = dress
//    }
}
