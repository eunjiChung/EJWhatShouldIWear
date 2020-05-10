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

struct EJLocationDefaultValue {
    static let latitude     = 37.51151
    static let longitude    = 127.0967
    static let country      = "Korea"
    static let location     = "서울시 송파구 송파동"
}

public class EJLocationManager: CLLocationManager {
    // MARK: Shared Instance
    static let shared = EJLocationManager()
    
    // MARK: Properties
    var koreaCities: [EJKoreaCityModel]?
    
    var latitude: Double {
        if let lat = mainLocation?[EJLocationMainKey.latitude] as? Double { return lat }
        return EJLocationDefaultValue.latitude
    }
    
    var longitude: Double {
        if let lon = mainLocation?[EJLocationMainKey.longitude] as? Double { return lon }
        return EJLocationDefaultValue.longitude
    }
    
    var country: String {
        if let country = mainLocation?[EJLocationMainKey.country] as? String { return country }
        return EJLocationDefaultValue.country
    }
    
    var currentLocation: String {
        if let location = mainLocation?[EJLocationMainKey.location] as? String { return location }
        return EJLocationDefaultValue.location
    }
    
    var mainLocation: [String: Any]? {
        guard let location = myUserDefaults.dictionary(forKey: UserDefaultKey.mainLocation.rawValue) else { return nil }
        return location
    }
    
    var hasMainLocations: Bool {
        guard mainLocation != nil else { return false }
        return true
    }
    
    var didRestrictLocationAuthorizationClosure: (()->())?
    var didSuccessUpdateLocationsClosure: (() -> Void)?
    var didFailUpdateLocationClosure: ((String)->Void)?
    
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
                // TODO: - subLocality가 잘 붙는지 확인
                if let firstLocality = first.locality { result += "\(firstLocality)" }
                if let subLocality = first.subLocality { result += " \(subLocality)" }
                self.setNewDefaults(current, country, result)
                
                self.didSuccessUpdateLocationsClosure?()
            } else {
                self.didFailUpdateLocationClosure?("Failed generating location!")
            }
        }
    }
    
    func isKorea() -> Bool {
        if country == "korea".localized { return true }
        return false
    }
    
    func setNewDefaults(_ newLocation: CLLocation, _ country: String, _ name: String) {
        let dict: [String: Any] = [
            EJLocationMainKey.location  : name,
            EJLocationMainKey.country   : country,
            EJLocationMainKey.latitude  : newLocation.coordinate.latitude,
            EJLocationMainKey.longitude : newLocation.coordinate.longitude
        ]
        myUserDefaults.set(dict, forKey: UserDefaultKey.mainLocation.rawValue)
    }
    
    func checkAuthorization(_ status: CLAuthorizationStatus?) {
        var authStatus = CLLocationManager.authorizationStatus()
        if status != nil { authStatus = status! }
        
        switch authStatus {
        case .notDetermined, .restricted, .denied:
            didRestrictLocationAuthorizationClosure?()
        case .authorizedAlways, .authorizedWhenInUse:
            if !hasMainLocations {
                startUpdatingLocation()
            } else {
                didSuccessUpdateLocationsClosure?()
            }
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
                self.setNewDefaults(location, country, address)
                self.didSuccessUpdateLocationsClosure?()
            }
        } else {
            myUserDefaults.removeObject(forKey: UserDefaultKey.mainLocation.rawValue)
            startUpdatingLocation()
        }
    }
}

extension EJLocationManager: CLLocationManagerDelegate {
    // 처음 앱을 켤 때 & 권한 설정을 수정할 때
    public func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        checkAuthorization(status)
    }
    
    // 위치를 업데이트할때 호출
    public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let current = locations.last else { return }
        getLocation(of: current)
    }
}
