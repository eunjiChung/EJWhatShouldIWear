//
//  EJShowClothViewModel.swift
//  EJWhatShouldIWear
//
//  Created by chungeunji on 2020/06/01.
//  Copyright © 2020 DEV_MOBILE_IOS_JUNIOR. All rights reserved.
//

import Foundation

enum EJTimeSection: String {
    case morning6 = "0600"
    case morning9 = "0900"
    case day12    = "1200"
    case day15    = "1500"
    case night18  = "1800"
    case night21  = "2100"
}

enum EJMonth: Int {
    case jan = 1, feb, march, april, may, june, july, aug, sep, oct, nov, dec
}

enum EJShowClothType {
    case outer
    case top
    case bottom
}

final class EJShowClothViewModel {
    public func generateAverageTemperature(with models: [EJKisangTimeModel]?) -> String {
        guard let models = models else { return "" }
        let date = models.first?.fcstDate
        
        var totalTemp = 0
        var count = 0
        for model in models where model.fcstDate == date {
            totalTemp += model.temperature
            count += 1
        }
        return "\(totalTemp / count)"
    }
    
    public func generateDescription(with models: [EJKisangTimeModel]?) -> String {
        guard let models = models else { return "" }
        var description = ""

        let weatherDesc = generateWeatherDescription(models)
        let dressDesc = generateClothDescription(models)
        
        if weatherDesc.rainyDesc != "" {
            description += (weatherDesc.rainyDesc + "\n")
        } else {
            description += (weatherDesc.skyDesc + "\n")
        }
        description += dressDesc
        return description
    }

    private func generateWeatherDescription(_ models: [EJKisangTimeModel]) -> (rainyDesc: String, skyDesc: String) {
        guard let baseDate = models.first?.fcstDate else { return ("", "") }

        var rainInfo: [(type: EJWeatherType, time: String)] = []
        var skyInfo: [(type: EJWeatherType, time: String)] = []
        for model in models where baseDate == model.fcstDate {
            if model.weatherCode.value.condition == .rainy {
                rainInfo.append((type: model.weatherCode.value.type, time: model.fcstTime))
            } else {
                skyInfo.append((type: model.weatherCode.value.type, time: model.fcstTime))
            }
        }

        var skyDesc = "오늘은 하루종일 맑아요!☀️"
        var rainyDesc = ""
        // 1. 비는 오는지 안 오는지
        if rainInfo.count > 0 {
            var isMorningRainy = false
            var isAfternoonRainy = false
            var isNightRainy = false

            rainInfo.forEach { (rain) in
                guard let timeSection = EJTimeSection(rawValue: rain.time) else { return }
                switch timeSection {
                case .morning6, .morning9:  isMorningRainy = true
                case .day12, .day15:        isAfternoonRainy = true
                case .night18, .night21:    isNightRainy = true
                }
            }

            if isMorningRainy && isAfternoonRainy && isNightRainy {
                rainyDesc = "오늘은 하루종일 비가 와요☔️"
            } else {
                if isMorningRainy, !isAfternoonRainy, !isNightRainy {
                    rainyDesc = "오늘 아침엔 비가 와요☔️"
                } else if !isMorningRainy, isAfternoonRainy, !isNightRainy {
                    rainyDesc = "오늘 오후엔 비가 와요☔️"
                } else if !isMorningRainy, !isAfternoonRainy, isNightRainy {
                    rainyDesc = "오늘 저녁엔 비가 와요☔️"
                } else if isMorningRainy, isAfternoonRainy, !isNightRainy {
                    rainyDesc = "오늘은 아침,점심에 비가 와요☔️"
                } else if isMorningRainy, !isAfternoonRainy, isNightRainy {
                    rainyDesc = "오늘은 아침,저녁으로 비가 와요☔️"
                } else if !isMorningRainy, isAfternoonRainy, isNightRainy {
                    rainyDesc = "오늘은 오후내내 비가 와요☔️"
                }
            }
        } else {
            // 2. 하늘은 맑은지 안 맑은지
            skyInfo.forEach { (sky) in
                if sky.type != .sunny {
                    skyDesc = "오늘은 흐린날이에요.."
                }
            }
        }

        return (rainyDesc, skyDesc)
    }

    private func generateClothDescription(_ models: [EJKisangTimeModel]) -> String {
        var dressDesc = ""
        let info = EJWeatherManager.shared.todayTempInfo(with: models)
        let outer = EJClothManager.shared.setOuterCloth(by: EJWeatherManager.shared.properSeasonValue(info.date, info.minTemp, info.maxTemp))
        if (info.minTemp - info.maxTemp).magnitude >= 10, info.maxTemp < 23 {
            dressDesc = "일교차가 크니 " + outer.localized + " 챙기세요!"
        } else {
            let todayTemp = EJWeatherManager.shared.properSeasonValue(info.date, info.minTemp, info.maxTemp)
            switch todayTemp {
            case TempRange.temp_28, TempRange.temp_23_27:
                dressDesc = "엄청 더워요!"
            case TempRange.temp_20_22, TempRange.temp_17_19, TempRange.temp_12_16:
                dressDesc = outer.localized + " 추천드려요"
            case TempRange.temp_9_11, TempRange.temp_5_8:
                dressDesc = "날씨가 쌀쌀해요 " + outer.localized + " 추천드려요"
            case TempRange.temp_4:
                dressDesc = "엄청 추워요! 따뜻하게 " + outer.localized + " 입으세요"
            default:
                EJLogger.d("")
            }
        }
        return dressDesc
    }
    
    public func generatePointCloth(with items: [EJKisangTimeModel]?) -> String {
        let type = EJWeatherManager.shared.priority(of: items)
        let point = EJClothManager.shared.setItem(by: type)
        if point == "outer" { return generateCloth(type: .outer, EJWeatherManager.shared.todayTempInfo(with: items)) }
        return point
    }
    
    public func generateCloth(type: EJShowClothType, _ info: (date: String, minTemp: Int, maxTemp: Int)) -> String {
        switch type {
        case .outer:
            return EJClothManager.shared.setOuterCloth(by: EJWeatherManager.shared.properSeasonValue(info.date, info.minTemp, info.maxTemp))
        case .top:
            return EJClothManager.shared.setTopCloth(by: EJWeatherManager.shared.properSeasonValue(info.date, info.minTemp, info.maxTemp))
        case .bottom:
            return EJClothManager.shared.setBottomCloth(by: EJWeatherManager.shared.properSeasonValue(info.date, info.minTemp, info.maxTemp))
        }
    }
}
