//
//  EJLocationManager.swift
//  EJWhatShouldIWear
//
//  Created by chungeunji on 2020/04/19.
//  Copyright © 2020 DEV_MOBILE_IOS_JUNIOR. All rights reserved.
//

import Foundation
import CoreLocation

struct EJLocationMainKey {
    static let location     = "location"
    static let latitude     = "latitude"
    static let longitude    = "longitude"
    static let country      = "country"
}

enum EJCountryType: String, CaseIterable {
    case korea              = "korea"
    case foreign            = "no_korea"
}

struct EJKoreaDefaultValue {
    static let latitude     = 37.51151
    static let longitude    = 127.0967
    static let country      = "korea".localized
    static let location     = "서울시 송파구 송파동"
}

struct EJLocationDefaultValue {
    static let latitude     = 37.7749
    static let longitude    = 122.4194
    static let country      = "USA"
    static let location     = "San Francisco"
}

public class EJLocationManager: CLLocationManager {
    // MARK: Shared Instance
    static let shared = EJLocationManager()
    
    // MARK: Properties
    var selectedCountry: EJCountryType?
    var koreaCities: [EJKoreaCityModel]?
    var koreaCodes: EJKoreaRegionModel?
    
    var latitude: Double {
        if let lat = mainLocation?[EJLocationMainKey.latitude] as? Double { return lat }
        return EJKoreaDefaultValue.latitude
    }
    
    var longitude: Double {
        if let lon = mainLocation?[EJLocationMainKey.longitude] as? Double { return lon }
        return EJKoreaDefaultValue.longitude
    }
    
    var country: String? {
        if !myUserDefaults.bool(forKey: UserDefaultKey.isExistingUser) { return nil }
        if let country = mainLocation?[EJLocationMainKey.country] as? String { return country }
        return selectedCountry?.rawValue ?? EJKoreaDefaultValue.country
    }
    
    var currentLocation: String {
        if let location = mainLocation?[EJLocationMainKey.location] as? String { return location }
        return EJKoreaDefaultValue.location
    }
    
    var mainLocation: [String: Any]? {
        guard let location = myUserDefaults.dictionary(forKey: UserDefaultKey.mainLocation) else { return nil }
        return location
    }
    
    var hasMainLocations: Bool {
        guard let _ = mainLocation else { return false }
        return true
    }
    
    var authStatus: CLAuthorizationStatus {
        return CLLocationManager.authorizationStatus()
    }
    
    // MARK: - GRID for Kisangchung
    var grid: (X: Int, Y: Int) {
        let coordinate = EJConvertHelper().convertGRID_GPS(mode: .TO_GRID, latitude: latitude, longitude: longitude)
        return (coordinate.X, coordinate.Y)
    }
    
    var regionCode: String {
        let region = currentLocation.split(separator: " ")
        guard let first = region.first, let codeModels = koreaCodes?.code else { return "11B10101" }
        
        // 현재 location에서 city 이름을 가져온다
        let area = "\(first)"
        let subLocality = "\(region[1])"
        
        if bigCities.contains(area) {
            // city 이름을 비교하여 id리턴
            if let model = codeModels.first?[area], let code = model.first?.code { return code }
        } else {
            // sublocality까지 비교해서 id리턴
            for areaModel in codeModels {
                if let models = areaModel[area] {
                    for model in models {
                        if model.district == subLocality { return model.code }
                    }
                }
            }
        }
        
        return "11B10101"
    }
    
    let bigCities = [ "서울특별시", "부산광역시", "대구광역시", "인천광역시", "광주광역시", "대전광역시", "울산광역시", "세종특별자치시"]
    
    // MARK: - Closure
    var didRestrictLocationAuthorizationClosure: (()->())?
    var didSuccessUpdateLocationsClosure: (() -> Void)?
    var didFailUpdateLocationClosure: ((String)->Void)?
    var didRestrictAbroadAuthorizationClosure: (()->())?
    
    // MARK: Initialize
    public override init() {
        super.init()
        self.delegate = self
        self.desiredAccuracy = kCLLocationAccuracyThreeKilometers
    }
    
    // MARK: Public Methods
    func getLocation(of current: CLLocation) {
        CLGeocoder().reverseGeocodeLocation(current) { placemark, error in
            if let error = error { self.didFailUpdateLocationClosure?(error.localizedDescription) }

            if let first = placemark?.first, let country = first.country {
                var result = ""
                if let adminArea = first.administrativeArea { result += adminArea }
                if let firstLocality = first.locality { result += " \(firstLocality)" }
                if let subLocality = first.subLocality { result += " \(subLocality)" }
                self.setNewDefaults(newLocation: current, country: country, name: result)
                
                self.didSuccessUpdateLocationsClosure?()
            } else {
                self.didFailUpdateLocationClosure?("Failed generating location!")
            }
        }
    }
    
    func isKorea() -> Bool {
        if let country = country, country == "korea".localized {
            return true
        }
        return false
    }
    
    func setForeignDefault() {
        let dict: [String: Any] = [
            EJLocationMainKey.location : EJLocationDefaultValue.location,
            EJLocationMainKey.country : EJLocationDefaultValue.country,
            EJLocationMainKey.latitude : EJLocationDefaultValue.latitude,
            EJLocationMainKey.longitude : EJLocationDefaultValue.longitude
        ]
        myUserDefaults.set(dict, forKey: UserDefaultKey.mainLocation)
    }
    
    func setNewDefaults(newLocation: CLLocation? = nil, country: String? = nil, name: String? = nil) {
        let dict: [String: Any] = [
            EJLocationMainKey.location  : name ?? EJKoreaDefaultValue.location,
            EJLocationMainKey.country   : country ?? EJKoreaDefaultValue.country,
            EJLocationMainKey.latitude  : newLocation?.coordinate.latitude ?? EJKoreaDefaultValue.latitude,
            EJLocationMainKey.longitude : newLocation?.coordinate.longitude ?? EJKoreaDefaultValue.longitude
        ]
        myUserDefaults.set(dict, forKey: UserDefaultKey.mainLocation)
    }
    
    func checkAuthorization(_ status: CLAuthorizationStatus?) {
        
        if hasMainLocations {
            didSuccessUpdateLocationsClosure?()
        } else {
            var authStatus = self.authStatus
            if status != nil { authStatus = status! }
            
            switch authStatus {
            case .notDetermined:
                requestWhenInUseAuthorization()
            case .restricted, .denied:
                didRestrictLocationAuthorizationClosure?()
            case .authorizedAlways, .authorizedWhenInUse:
                startUpdatingLocation()
            @unknown default:
                fatalError()
            }
        }
    }
    
    func checkAbroadAuthorization() {
        switch authStatus {
        case .notDetermined:
            requestWhenInUseAuthorization()
        case .restricted, .denied:
            didRestrictAbroadAuthorizationClosure?()
        case .authorizedAlways, .authorizedWhenInUse:
            startUpdatingLocation()
        @unknown default:
            fatalError()
        }
    }
    
    func setDefaultKoreaLocationList() {
        if let path = Bundle.main.path(forResource: "korea", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let model = try JSONDecoder().decode(EJKoreaLocalModel.self, from: data)
                koreaCities = model.korea
            } catch {
                EJLogger.e("Failed to generate Korea cities")
            }
        }
    }
    
    public func updateMainLocation(_ newLocation: String?) {
        if let address = newLocation {
            CLGeocoder().geocodeAddressString(address) { placemarks, error in
                if error != nil { return }
                
                guard let first = placemarks?.first, let location = first.location, let country = first.country else { return }
                self.setNewDefaults(newLocation: location, country: country, name: address)
                
                // TODO: - Notification Sending으로 바꾸기
                self.didSuccessUpdateLocationsClosure?()
            }
        } else {
            myUserDefaults.removeObject(forKey: UserDefaultKey.mainLocation)
            checkAuthorization(nil)
        }
    }
}

extension EJLocationManager: CLLocationManagerDelegate {
    // 처음 앱을 켤 때 & 권한 설정을 수정할 때
    public func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        guard myUserDefaults.bool(forKey: UserDefaultKey.isExistingUser) else { return }
        
        if isKorea() {
            checkAuthorization(status)
        } else {
            checkAbroadAuthorization()
        }
    }
    
    // 위치를 업데이트할때 호출
    public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let current = locations.last else { return }
        getLocation(of: current)
    }
}

extension EJLocationManager {
    
    public func setRegionId() {
        
        guard let path = Bundle.main.path(forResource: "regionId", ofType: "json")  else { return }
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path), options:  .mappedIfSafe)
            let model = try JSONDecoder().decode(EJKoreaRegionModel.self, from: data)
            koreaCodes = model
        } catch {
            EJLogger.d("Failed to generate Korea region id")
        }
    }
}
