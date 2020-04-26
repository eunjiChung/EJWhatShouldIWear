//
//  EJThreedaysFcst3hourModel.swift
//  EJWhatShouldIWear
//
//  Created by chungeunji on 2020/04/17.
//  Copyright © 2020 DEV_MOBILE_IOS_JUNIOR. All rights reserved.
//

import Foundation

public struct EJThreedaysFcst3hourModel: Decodable {
    private enum CodingKeys: String, CodingKey {
        case wind = "wind"
        case precipitation = "precipitation"
        case sky = "sky"
        case temperature = "temperature"
        case humidity = "humidity"
    }
    
    public var wind: EJThreedaysWindModel
    public var precipitation: EJPrecipitationModel
    public var sky: EJSkyModel
    public var temperature: EJThreedaysHourTemperature
    public var humidity: EJHumidityModel
}

/*
 {
     "weather": {
         "forecast3days": [
             {
                 "grid": {
                     "city": "서울",
                     "county": "강남구",
                     "village": "도곡동",
                     "longitude": "127.04604",
                     "latitude": "37.48706"
                 },
                 "timeRelease": "2020-04-26 11:00:00",
                 "fcst3hour": {
                     "wind": {
                         "wdir4hour": "301.00",
                         "wspd4hour": "4.90",
                         "wdir7hour": "270.00",
                         "wspd7hour": "4.50",
                         "wdir10hour": "277.00",
                         "wspd10hour": "3.00",
                         "wdir13hour": "305.00",
                         "wspd13hour": "1.30",
                         "wdir16hour": "291.00",
                         "wspd16hour": "0.90",
                         "wdir19hour": "225.00",
                         "wspd19hour": "0.70",
                         "wdir22hour": "274.00",
                         "wspd22hour": "1.30",
                         "wdir25hour": "291.00",
                         "wspd25hour": "2.40",
                         "wdir28hour": "287.00",
                         "wspd28hour": "3.30",
                         "wdir31hour": "270.00",
                         "wspd31hour": "2.70",
                         "wdir34hour": "298.00",
                         "wspd34hour": "1.60",
                         "wdir37hour": "325.00",
                         "wspd37hour": "1.10",
                         "wdir40hour": "323.00",
                         "wspd40hour": "0.90",
                         "wdir43hour": "216.00",
                         "wspd43hour": "0.90",
                         "wdir46hour": "207.00",
                         "wspd46hour": "1.40",
                         "wdir49hour": "241.00",
                         "wspd49hour": "2.60",
                         "wdir52hour": "245.00",
                         "wspd52hour": "3.60",
                         "wdir55hour": "241.00",
                         "wspd55hour": "3.00",
                         "wdir58hour": "212.00",
                         "wspd58hour": "1.90",
                         "wdir61hour": "191.00",
                         "wspd61hour": "1.50",
                         "wdir64hour": "",
                         "wspd64hour": "",
                         "wdir67hour": "",
                         "wspd67hour": ""
                     },
                     "precipitation": {
                         "type4hour": "0",
                         "prob4hour": "20.00",
                         "type7hour": "0",
                         "prob7hour": "20.00",
                         "type10hour": "0",
                         "prob10hour": "0.00",
                         "type13hour": "0",
                         "prob13hour": "0.00",
                         "type16hour": "0",
                         "prob16hour": "20.00",
                         "type19hour": "0",
                         "prob19hour": "20.00",
                         "type22hour": "0",
                         "prob22hour": "20.00",
                         "type25hour": "0",
                         "prob25hour": "0.00",
                         "type28hour": "0",
                         "prob28hour": "20.00",
                         "type31hour": "0",
                         "prob31hour": "20.00",
                         "type34hour": "0",
                         "prob34hour": "0.00",
                         "type37hour": "0",
                         "prob37hour": "0.00",
                         "type40hour": "0",
                         "prob40hour": "0.00",
                         "type43hour": "0",
                         "prob43hour": "0.00",
                         "type46hour": "0",
                         "prob46hour": "0.00",
                         "type49hour": "0",
                         "prob49hour": "0.00",
                         "type52hour": "0",
                         "prob52hour": "0.00",
                         "type55hour": "0",
                         "prob55hour": "0.00",
                         "type58hour": "0",
                         "prob58hour": "0.00",
                         "type61hour": "0",
                         "prob61hour": "0.00",
                         "type64hour": "",
                         "prob64hour": "",
                         "type67hour": "",
                         "prob67hour": ""
                     },
                     "sky": {
                         "code4hour": "SKY_S03",
                         "name4hour": "구름많음",
                         "code7hour": "SKY_S03",
                         "name7hour": "구름많음",
                         "code10hour": "SKY_S01",
                         "name10hour": "맑음",
                         "code13hour": "SKY_S01",
                         "name13hour": "맑음",
                         "code16hour": "SKY_S03",
                         "name16hour": "구름많음",
                         "code19hour": "SKY_S03",
                         "name19hour": "구름많음",
                         "code22hour": "SKY_S03",
                         "name22hour": "구름많음",
                         "code25hour": "SKY_S01",
                         "name25hour": "맑음",
                         "code28hour": "SKY_S03",
                         "name28hour": "구름많음",
                         "code31hour": "SKY_S03",
                         "name31hour": "구름많음",
                         "code34hour": "SKY_S01",
                         "name34hour": "맑음",
                         "code37hour": "SKY_S01",
                         "name37hour": "맑음",
                         "code40hour": "SKY_S01",
                         "name40hour": "맑음",
                         "code43hour": "SKY_S01",
                         "name43hour": "맑음",
                         "code46hour": "SKY_S01",
                         "name46hour": "맑음",
                         "code49hour": "SKY_S01",
                         "name49hour": "맑음",
                         "code52hour": "SKY_S01",
                         "name52hour": "맑음",
                         "code55hour": "SKY_S01",
                         "name55hour": "맑음",
                         "code58hour": "SKY_S01",
                         "name58hour": "맑음",
                         "code61hour": "SKY_S01",
                         "name61hour": "맑음",
                         "code64hour": "",
                         "name64hour": "",
                         "code67hour": "",
                         "name67hour": ""
                     },
                     "temperature": {
                         "temp4hour": "18.00",
                         "temp7hour": "15.00",
                         "temp10hour": "12.00",
                         "temp13hour": "10.00",
                         "temp16hour": "8.00",
                         "temp19hour": "8.00",
                         "temp22hour": "13.00",
                         "temp25hour": "17.00",
                         "temp28hour": "18.00",
                         "temp31hour": "15.00",
                         "temp34hour": "13.00",
                         "temp37hour": "10.00",
                         "temp40hour": "9.00",
                         "temp43hour": "7.00",
                         "temp46hour": "14.00",
                         "temp49hour": "18.00",
                         "temp52hour": "19.00",
                         "temp55hour": "17.00",
                         "temp58hour": "14.00",
                         "temp61hour": "11.00",
                         "temp64hour": "",
                         "temp67hour": ""
                     },
                     "humidity": {
                         "rh4hour": "25.00",
                         "rh64hour": "",
                         "rh67hour": "",
                         "rh7hour": "35.00",
                         "rh10hour": "50.00",
                         "rh13hour": "70.00",
                         "rh16hour": "75.00",
                         "rh19hour": "80.00",
                         "rh22hour": "55.00",
                         "rh25hour": "25.00",
                         "rh28hour": "25.00",
                         "rh31hour": "40.00",
                         "rh34hour": "45.00",
                         "rh37hour": "55.00",
                         "rh40hour": "60.00",
                         "rh43hour": "70.00",
                         "rh46hour": "45.00",
                         "rh49hour": "30.00",
                         "rh52hour": "30.00",
                         "rh55hour": "40.00",
                         "rh58hour": "50.00",
                         "rh61hour": "65.00"
                     }
                 },
                 "fcst6hour": {
                     "rain6hour": "없음",
                     "rain12hour": "없음",
                     "rain18hour": "없음",
                     "rain24hour": "없음",
                     "rain30hour": "없음",
                     "rain36hour": "없음",
                     "rain42hour": "없음",
                     "rain48hour": "없음",
                     "rain54hour": "없음",
                     "snow6hour": "없음",
                     "snow12hour": "없음",
                     "snow18hour": "없음",
                     "snow24hour": "없음",
                     "snow30hour": "없음",
                     "snow36hour": "없음",
                     "snow42hour": "없음",
                     "snow48hour": "없음",
                     "snow54hour": "없음",
                     "rain60hour": "없음",
                     "rain66hour": "",
                     "snow60hour": "없음",
                     "snow66hour": ""
                 },
                 "fcstdaily": {
                     "temperature": {
                         "tmax1day": "20.00",
                         "tmax2day": "19.00",
                         "tmax3day": "20.00",
                         "tmin1day": "",
                         "tmin2day": "7.00",
                         "tmin3day": "7.00"
                     }
                 }
             }
         ]
     },
     "common": {
         "alertYn": "Y",
         "stormYn": "N"
     },
     "result": {
         "code": 9200,
         "requestUrl": "/weather/forecast/3days?appKey=cd0c9c72-6e32-4181-9291-9340adb8d0dc&lat=37.49565165347053&lon=127.02807040619024",
         "message": "성공"
     }
 }
 */
