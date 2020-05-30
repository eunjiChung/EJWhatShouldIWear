//
//  EJConvertHelper.swift
//  EJWhatShouldIWear
//
//  Created by chungeunji on 2020/05/26.
//  Copyright © 2020 DEV_MOBILE_IOS_JUNIOR. All rights reserved.
//

import Foundation

// Swift 5.2 기준
enum ConversionMode: String {
    case TO_GRID
    case TO_GPS
}

struct EJCoordinate {
    public var latitude: Double
    public var longitude: Double
    
    public var X: Int
    public var Y: Int
}

/// GPS <-> GRID
/// LCC DFS 좌표변환
final class EJConvertHelper {
    
    func convertGRID_GPS(mode: ConversionMode, latitude: Double = 0, longitude: Double = 0, gridX: Int = 0, gridY: Int = 0) -> EJCoordinate {
        let EARTH_RADIUS = 6371.00877           // 지구 반경(km)
        let GRID_SPACING = 5.0                  // 격자 간격(km)
        let PROJECTION_LATITUDE1 = 30.0         // 투영 위도1(degree)
        let PROJECTION_LATITUDE2 = 60.0         // 투영 위도2(degree)
        let OLON = 126.0                        // 기준점 경도(degree)
        let OLAT = 38.0                         // 기준점 위도(degree)
        let XO:Double = 43                      // 기준점 X좌표(GRID)
        let YO:Double = 136                     // 기준점 Y좌표(GRID)
        
        let DEGRAD = Double.pi / 180.0
        let RADDEG = 180.0 / Double.pi
        
        let re = EARTH_RADIUS / GRID_SPACING
        let slat1 = PROJECTION_LATITUDE1 * DEGRAD
        let slat2 = PROJECTION_LATITUDE2 * DEGRAD
        let olon = OLON * DEGRAD
        let olat = OLAT * DEGRAD
        
        var sn = tan(Double.pi * 0.25 + slat2 * 0.5) / tan(Double.pi * 0.25 + slat1 * 0.5)
        sn = log(cos(slat1) / cos(slat2)) / log(sn)
        var sf = tan(Double.pi * 0.25 + slat1 * 0.5)
        sf = pow(sf, sn) * cos(slat1) / sn
        var ro = tan(Double.pi * 0.25 + olat * 0.5)
        ro = re * sf / pow(ro, sn)
        var rs = EJCoordinate(latitude: 0, longitude: 0, X: 0, Y: 0)
        
        switch mode {
        case .TO_GPS:
            rs.X = Int(latitude)
            rs.Y = Int(longitude)
            
            let xn = latitude - XO
            let yn = ro - longitude + YO
            
            var ra = sqrt(xn * xn + yn * yn)
            if (sn < 0.0) {
                ra = -ra
            }
            
            var alat = pow((re * sf / ra), (1.0 / sn))
            alat = 2.0 * atan(alat) - Double.pi * 0.5
            
            var theta = 0.0
            if (abs(xn) <= 0.0) {
                theta = 0.0
            } else {
                if (abs(yn) <= 0.0) {
                    theta = Double.pi * 0.5
                    if (xn < 0.0) {
                        theta = -theta
                    }
                } else {
                    theta = atan2(xn, yn)
                }
            }
            
            let alon = theta / sn + olon
            rs.latitude = alat * RADDEG
            rs.longitude = alon * RADDEG
        case .TO_GRID:
            rs.latitude = Double(gridX)
            rs.longitude = Double(gridY)
            
            var ra = tan(Double.pi * 0.25 + Double(gridX) * DEGRAD * 0.5)
            ra = re * sf / pow(ra, sn)
            
            var theta = Double(gridY) * DEGRAD - olon
            if theta > Double.pi {
                theta -= 2.0 * Double.pi
            }
            if theta < -Double.pi {
                theta += 2.0 * Double.pi
            }
            
            theta *= sn
            rs.X = Int(floor(ra * sin(theta) + XO + 0.5))
            rs.Y = Int(floor(ro - ra * cos(theta) + YO + 0.5))
        }
        
        return rs
    }
}
