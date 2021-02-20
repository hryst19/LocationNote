//
//  LocationManager.swift
//  LocationNotes
//
//  Created by hryst on 8/21/19.
//  Copyright © 2019 Anton Mikliayev. All rights reserved.
//

import UIKit
import CoreLocation


struct LocationCoordinate {
    var lat: Double
    var lon: Double
    
    static func create(location: CLLocation ) -> LocationCoordinate {
        return LocationCoordinate(lat: location.coordinate.latitude, lon: location.coordinate.longitude)
    }
}


class LocationManager: NSObject, CLLocationManagerDelegate {
    
    // синголтон
   static let sharedInstance = LocationManager()
    
    
    var manager = CLLocationManager()
    
    func requestAuthorization()  {
       manager.requestWhenInUseAuthorization()
    }
    
    var blockForSave: ((LocationCoordinate) -> Void)?
    
    func getCurrentLocation(block:((LocationCoordinate) -> Void)?) {
        if CLLocationManager.authorizationStatus() != .authorizedWhenInUse {
            print("Пользователь не дал доступ к локации")
            return
        }
        
        blockForSave = block
        
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.activityType = .other
        
        manager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let lc = LocationCoordinate.create(location: locations.last!)
        blockForSave?(lc)
        
        manager.stopUpdatingLocation()
    }
    
}
