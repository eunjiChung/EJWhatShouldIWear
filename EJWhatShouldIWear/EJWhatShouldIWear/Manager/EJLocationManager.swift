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
    
    // MARK: Initialize
    override init() {
        super.init()
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
        if myUserDefaults.dictionary(forKey: LOCATION_KEY) == nil {
            let dictionary = ["latitude" : 37.50587, "longitude" : 127.11246]
            myUserDefaults.set(dictionary, forKey: LOCATION_KEY)
        }
        
        guard let location = myUserDefaults.dictionary(forKey: LOCATION_KEY) else { return }
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
        myUserDefaults.set(newCoordinate, forKey: LOCATION_KEY)
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
    
    
    // MARK: Request
    func requestKoreaWeatherInfo(_ index: Int) {
        
    }
    
    func requestAbroadWeatherInfo(of current: CLLocation) {
        
    }
}
