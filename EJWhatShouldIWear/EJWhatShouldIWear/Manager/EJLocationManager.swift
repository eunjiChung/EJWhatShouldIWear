//
//  EJLocationManager.swift
//  EJWhatShouldIWear
//
//  Created by chungeunji on 2020/04/19.
//  Copyright © 2020 DEV_MOBILE_IOS_JUNIOR. All rights reserved.
//

import Foundation
import CoreLocation

struct EJMyLocalListNotification {
    static let didSelectMainLocation = NSNotification.Name(rawValue: "didSelectMainLocation")
}

public class EJLocationManager: CLLocationManager {
    // MARK: Shared Instance
    static let shared = EJLocationManager()
    
    // MARK: Properties
    var koreaCities: [EJKoreaCityModel]?
    
    var latitude: Double = 0    //37.51151
    var longitude: Double = 0   //127.0967
    var country = ""
    var locationString = "unknown".localized
    
    var mainCLLocation: CLLocation? {
        guard let location = myUserDefaults.object(forKey: UserDefaultKey.mainLocation.rawValue) as? CLLocation else { return  nil }
        return location
    }
    
    var hasMainLocations: Bool {
        guard mainCLLocation != nil else { return false }
        return true
    }
    
    var didRestrictLocationAuthorizationClosure: (()->())?
    var didChangeLocationAuthorizationRestrictedClosure: (() -> Void)?
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

                self.setNewDefaults(location: current)
                self.country = country
                self.locationString = result
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
    
    func updateDefaultLocation(currentLocation: CLLocation? = nil, completion: ((CLLocation) -> Void)? = nil) {
        if myUserDefaults.dictionary(forKey: UserDefaultKey.mainLocation.rawValue) == nil {
            let dictionary = ["latitude" : 37.50587, "longitude" : 127.11246]
            myUserDefaults.set(dictionary, forKey: UserDefaultKey.mainLocation.rawValue)
        }
        
        guard let location = myUserDefaults.dictionary(forKey: UserDefaultKey.mainLocation.rawValue) else { return }
        latitude = location["latitude"] as! Double
        longitude = location["longitude"] as! Double
        let defaultLocation = CLLocation(latitude: latitude, longitude: longitude)
        completion?(defaultLocation)
    }
    
    func setNewDefaults(location: CLLocation) {
        latitude = location.coordinate.latitude
        longitude = location.coordinate.longitude
        myUserDefaults.set(location, forKey: UserDefaultKey.mainLocation.rawValue)
    }
    
    func checkLocationStatus() {
        // TODO: - 확인하기
        if !hasMainLocations { startUpdatingLocation() }
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
        locationString = name
        convertAddressStringToLocationDegree()
    }
    
    public func convertAddressStringToLocationDegree() {
        let address = locationString
        CLGeocoder().geocodeAddressString(address) { placemarks, error in
            if error != nil { return }
            
            guard let first = placemarks?.first, let location = first.location, let country = first.country else { return }
            self.setNewDefaults(location: location)
            self.country = country
            // TODO: - 완료처리를 해줘야하지 않나?
//            self.didSuccessUpdateLocationsClosure?()
        }
    }
}

extension EJLocationManager: CLLocationManagerDelegate {
    // 처음 앱을 켤 때 & 권한 설정을 수정할 때
    public func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        guard !hasMainLocations else {
            didSuccessUpdateLocationsClosure?()
            return
        }
        
        switch status {
        case .notDetermined, .restricted, .denied:
            didRestrictLocationAuthorizationClosure?()
//            requestWhenInUseAuthorization()
        case .authorizedWhenInUse, .authorizedAlways:
            startUpdatingLocation()
        }
    }
    
    // 위치를 업데이트할때 
    public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let current = locations.last else { return }
        getLocation(of: current)
    }
}
