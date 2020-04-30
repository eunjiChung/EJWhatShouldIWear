//
//  EJLocationManager.swift
//  EJWhatShouldIWear
//
//  Created by chungeunji on 2020/04/19.
//  Copyright © 2020 DEV_MOBILE_IOS_JUNIOR. All rights reserved.
//

import Foundation
import CoreLocation

public class EJLocationManager: CLLocationManager {
    // MARK: Shared Instance
    static let shared = EJLocationManager()
    
    // MARK: Properties
    var latitude: Double = 0    //37.51151
    var longitude: Double = 0   //127.0967
    var country = ""
    var currentLocation: CLLocation?
    var locationString = LocalizedString(with: "unknown")
    
    var koreaCities: [EJKoreaCityModel]?
    
    var didChangeLocationAuthorizationRestrictedClosure: (() -> Void)?
    var didUpdateLocationsClosure: (([CLLocation]?) -> Void)?
    
    // MARK: Initialize
    override init() {
        super.init()
        self.delegate = self
        self.desiredAccuracy = kCLLocationAccuracyThreeKilometers
    }
    
    // MARK: Public Methods
    func getLocation(of current: CLLocation,
                     success: @escaping (String, String) -> Void,
                     failure: @escaping (Error) -> Void) {
        CLGeocoder().reverseGeocodeLocation(current) { placemark, error in
            if let error = error {
                failure(error)
            } else {
                var result = ""
                
                if let placemark = placemark, let first = placemark.first, let country = first.country {
                    if let firstLocality = first.locality {
                        result += "\(firstLocality)"
                        
                        if let subLocality = first.subLocality {
                            result += " \(subLocality)"
                        }
                    }
                    
                    self.country = country
                    success(country, result)
                } else {
                    success("", result)
                }
            }
        }
    }
    
    func isKorea() -> Bool {
        if country == LocalizedString(with: "korea") {
            return true
        }
        return false
    }
    
    func updateDefaultLocation(currentLocation: CLLocation? = nil, completion: ((CLLocation) -> Void)? = nil) {
        if myUserDefaults.dictionary(forKey: UserDefaultKey.locationKey.rawValue) == nil {
            let dictionary = ["latitude" : 37.50587, "longitude" : 127.11246]
            myUserDefaults.set(dictionary, forKey: UserDefaultKey.locationKey.rawValue)
        }
        
        guard let location = myUserDefaults.dictionary(forKey: UserDefaultKey.locationKey.rawValue) else { return }
        latitude = location["latitude"] as! Double
        longitude = location["longitude"] as! Double
        let defaultLocation = CLLocation(latitude: latitude, longitude: longitude)
        completion?(defaultLocation)
    }
    
    func setNewLocationUserDefaults(location: CLLocation) {
        currentLocation = location
        latitude = location.coordinate.latitude
        longitude = location.coordinate.longitude
        let newCoordinate = ["latitude": latitude, "longitude": longitude]
        myUserDefaults.set(newCoordinate, forKey: UserDefaultKey.locationKey.rawValue)
    }
    
    func checkLocationStatus() {
        switch CLLocationManager.authorizationStatus() {
        case .notDetermined:
            requestWhenInUseAuthorization()
        case .restricted, .denied:
            updateDefaultLocation()
        case .authorizedAlways, .authorizedWhenInUse:
            startUpdatingLocation()
        }
    }
    
    func generateKoreaLocation() {
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
    
    func updateMainLocation(_ name: String) {
        // TODO: - 현재 로케이션 string을 저장한다
        // TODO: - 그 locationString을 CLLocation 값으로 변환한다!!!!
        // TODO: - Notification이나 delegate를 메인에 쏜다! -> 그래야 현재 메인 로케이션이 업데이트 됨
    }
    
    // MARK: Request
    func requestKoreaWeatherInfo(_ index: Int) {
        
    }
    
    func requestAbroadWeatherInfo(of current: CLLocation) {
        
    }
}

extension EJLocationManager: CLLocationManagerDelegate {
    public func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .notDetermined:
            EJLocationManager.shared.requestWhenInUseAuthorization()
        case .restricted, .denied:
            didChangeLocationAuthorizationRestrictedClosure?()
        case .authorizedWhenInUse, .authorizedAlways:
            if !EJUserDefaultsManager.shared.hasDefaultLocations {
                EJLocationManager.shared.startUpdatingLocation()
            } else {
                didUpdateLocationsClosure?(nil)
            }
            // TODO: - default location이 있을 경우, 현재 메인 location을 업데이트해준다
        }
    }
    
    public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        didUpdateLocationsClosure?(locations)
    }
}
