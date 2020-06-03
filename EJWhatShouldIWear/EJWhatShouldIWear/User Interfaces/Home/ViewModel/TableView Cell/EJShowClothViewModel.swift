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
    
    public func generateAverageTemperature(with models: [EJKisangTimelyModel]?) -> String {
        guard let models = models else { return "" }
        let date = models.first?.fcstDate
        
        var totalTemp = 0
        var count = 0
        for model in models {
            if model.fcstDate == date && model.category == .threeHourTemp {
                if let temp = Int(model.fcstValue) {
                    totalTemp += temp
                    count += 1
                }
            }
        }
        
        return "\(totalTemp / count)"
    }
    
    public func generateDescription(with models: [EJKisangTimelyModel]?) -> String {
        // TODO: - 우선순위를 두고 description 만들기
        var description = ""
        var minTemp = 0
        
        guard let models = models else { return "" }
        for model in models {
            guard let timeType = EJTimeSection(rawValue: model.fcstTime) else { return "" }
            guard let fcstValue = Int(model.fcstValue) else { return "" }
            let category = model.category
            
            switch timeType {
            case .morning6, .morning9:
                let morning = morningInfo(with: category, fcstValue, minTemp, description)
                description += morning.description
                minTemp = morning.minTemp
            case .day12, .day15:
                description += dayDescription(with: category, fcstValue, minTemp, description)
            case .night18, .night21:
                description += nightDescription(with: category, fcstValue, description)
            }
        }
        return description
    }
    
    public func generatePointCloth(with items: [EJKisangTimeModel]?) -> String {
        guard let items = items else { return "" }
        guard let baseDate = items.first?.fcstDate else { return "" }
        
        var originType: EJWeatherType = .no
        for model in items where baseDate == model.fcstDate {
            let skyType = EJWeatherManager.shared.criticCondition(by: .sky, code: model.skyCode)
            let rainyType = EJWeatherManager.shared.criticCondition(by: .rainy, code: model.rainyCode)
            guard let newType: EJWeatherType = EJWeatherType(rawValue: max(skyType.rawValue, rainyType.rawValue)) else { return "" }
            originType = EJWeatherType(rawValue: max(originType.rawValue, newType.rawValue)) ?? .no
        }
        
        return EJClothManager.shared.setItem(by: originType)
    }
    
    public func generateCloth(type: EJShowClothType,with items: [EJKisangTimeModel]?) -> String {
        guard let items = items else { return "" }
        guard let baseDate = items.first?.fcstDate else { return "" }
        
        var minTemp = 100
        var maxTemp = -100
        for model in items where baseDate == model.fcstDate {
            if model.fcstTime != "0000", model.fcstTime != "0300" {
                minTemp = min(minTemp, model.temperature)
                maxTemp = max(maxTemp, model.temperature)
            }
        }
        
        switch type {
        case .outer:
            return EJClothManager.shared.setOuterCloth(by: EJWeatherManager.shared.properSeasonValue(baseDate, minTemp, maxTemp))
        case .top:
            return EJClothManager.shared.setTopCloth(by: EJWeatherManager.shared.properSeasonValue(baseDate, minTemp, maxTemp))
        case .bottom:
            return EJClothManager.shared.setBottomCloth(by: EJWeatherManager.shared.properSeasonValue(baseDate, minTemp, maxTemp))
        }
    }
    
    // MARK: - Private Methods
    public func morningInfo(with category: EJKisangWeatherCode, _ value: Int, _ minTemp: Int, _ originDescription: String) -> (description:String, minTemp:Int) {
        var description = originDescription
        var resultTemp = 0
        let morningString = "아침에 "
        
        if !originDescription.contains(morningString) {
            description += morningString
        }
        
        switch category {
        case .threeHourTemp:
            if value < minTemp {
                resultTemp = value
            }
        case .rainFallType:
            guard let rainType = EJPrecipitationCode(rawValue: value) else { return ("", 0) }
            switch rainType {
            case .no:
                EJLogger.d("")
            case .rain:
                
                let string = "비가 내려요 "
                if !originDescription.contains("눈이 내려요 ") &&
                    !originDescription.contains("소나기가 내려요 ") &&
                    !originDescription.contains("비가 내려요 ") {
                    description += string
                }
            case .snow:
                let string = "눈이 내려요 "
                if !originDescription.contains("눈이 내려요 ") &&
                    !originDescription.contains("소나기가 내려요 ") &&
                    !originDescription.contains("비가 내려요 ") {
                    description += string
                }
            case .shower:
                let string = "소나기가 내려요 "
                if !originDescription.contains("눈이 내려요 ") &&
                    !originDescription.contains("소나기가 내려요 ") &&
                    !originDescription.contains("비가 내려요 ") {
                    description += string
                }
            case .both:
                let string = "비가 내려요 "
                if !originDescription.contains("눈이 내려요 ") &&
                    !originDescription.contains("소나기가 내려요 ") &&
                    !originDescription.contains("비가 내려요 ") {
                    description += string
                }
            }
        default:
            EJLogger.d("")
        }
        
        return (description, resultTemp)
    }
    
    func dayDescription(with category: EJKisangWeatherCode, _ value: Int, _ minTemp: Int, _ originDescription: String) -> String {
        var description = originDescription
        
        let day = "낮에 "
        
        switch category {
        case .noonMaxTemp:
            let today = "오늘 "
            if (value-minTemp).magnitude >= 10, minTemp <= 16 {
                if originDescription.contains(today) {
                    let string = "일교차는 커요! 겉옷을 챙기세요~"
                    if !originDescription.contains(string) &&
                        !originDescription.contains("일교차가 커요! 겉옷을 챙기세요~"){
                        description += string
                    }
                } else {
                    let string = today + "일교차가 커요! 겉옷을 챙기세요~"
                    if !originDescription.contains(string) {
                        description += string
                    }
                }
            }
        case .skyCode:
            if !description.contains(day) {
                description += day
            }
            
            guard let skyType = EJSkyCode(rawValue: value) else { return "" }
            switch skyType {
            case .sunny:
                let string = "날씨가 맑아요! "
                if !originDescription.contains("눈이 내려요 ") &&
                    !originDescription.contains("소나기가 내려요 ") &&
                    !originDescription.contains("비가 내려요 ") &&
                    !originDescription.contains("눈비가 내려요") &&
                    !originDescription.contains("날씨가 맑아요! ") &&
                    !originDescription.contains("구름이 많아요 ") &&
                    !originDescription.contains("날씨가 흐려요 ") {
                    description += string
                }
            case .cloudy:
                let string = "구름이 많아요 "
                if !originDescription.contains("눈이 내려요 ") &&
                    !originDescription.contains("소나기가 내려요 ") &&
                    !originDescription.contains("비가 내려요 ") &&
                    !originDescription.contains("눈비가 내려요") &&
                    !originDescription.contains("구름이 많아요 ") &&
                    !originDescription.contains("날씨가 흐려요 ") {
                    if originDescription.contains("날씨가 맑아요! ") {
                        description = description.replacingOccurrences(of: "날씨가 맑아요! ", with: string)
                    } else {
                        description += string
                    }
                }
            case .grey:
                let string = "날씨가 흐려요 "
                if !originDescription.contains("눈이 내려요 ") &&
                    !originDescription.contains("소나기가 내려요 ") &&
                    !originDescription.contains("비가 내려요 ") &&
                    !originDescription.contains("눈비가 내려요") &&
                    !originDescription.contains("날씨가 흐려요 ") {
                    ["날씨가 맑아요! ", "구름이 많아요 "].forEach { normal in
                        if originDescription.contains(normal) {
                            description = description.replacingOccurrences(of: normal, with: "")
                        }
                    }
                    description += string
                }
            }
        case .rainFallType:
            if !description.contains(day) {
                description += day
            }
            
            guard let rainType = EJPrecipitationCode(rawValue: value) else { return "" }
            switch rainType {
            case .rain:
                let string = "비가 내려요 "
                if !originDescription.contains("눈이 내려요 ") &&
                    !originDescription.contains("소나기가 내려요 ") &&
                    !originDescription.contains("비가 내려요 ") &&
                    !originDescription.contains("눈비가 내려요 ") {
                    ["날씨가 맑아요! ", "구름이 많아요 ", "날씨가 흐려요 "].forEach { normalString in
                        if originDescription.contains(normalString) {
                            description = description.replacingOccurrences(of: normalString, with: "")
                        }
                    }
                    description += string
                }
            case .shower:
                let string = "소나기가 내려요 "
                if !originDescription.contains("눈이 내려요 ") &&
                    !originDescription.contains("소나기가 내려요 ") &&
                    !originDescription.contains("눈비가 내려요 ") {
                    ["비가 내려요 ", "날씨가 맑아요! ", "구름이 많아요 ", "날씨가 흐려요 "].forEach { normalString in
                        if originDescription.contains(normalString) {
                            description = description.replacingOccurrences(of: normalString, with: "")
                        }
                    }
                    description += string
                }
            case .both:
                let string = "눈비가 내려요 "
                if !originDescription.contains("눈이 내려요 ") &&
                    !originDescription.contains("눈비가 내려요") {
                    ["소나기가 내려요 ", "비가 내려요 ", "날씨가 맑아요! ", "구름이 많아요 ", "날씨가 흐려요 "].forEach { normalString in
                        if originDescription.contains(normalString) {
                            description = description.replacingOccurrences(of: normalString, with: "")
                        }
                    }
                    description += string
                }
            case .snow:
                let string = "눈이 내려요 "
                if !originDescription.contains("눈이 내려요 ") {
                    ["눈비가 내려요 ", "소나기가 내려요 ", "비가 내려요 ", "날씨가 맑아요! ", "구름이 많아요 ", "날씨가 흐려요 "].forEach { normalString in
                        if originDescription.contains(normalString) {
                            description = description.replacingOccurrences(of: normalString, with: "")
                        }
                    }
                    description += string
                }
            case .no:
                EJLogger.d("")
            }
        default:
            EJLogger.d("")
        }
        
        return description
    }
    
    private func nightDescription(with category: EJKisangWeatherCode, _ value: Int, _ originDescription: String) -> String {
        var description = ""
        return description
    }
}
