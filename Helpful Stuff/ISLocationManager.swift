//
//  ISLocationManager.swift
//  GoTree
//
//  Created by Hernan Paez on 30/07/2018.
//  Copyright © 2018 InfinixSoft. All rights reserved.
//

import Foundation
import CoreLocation
import RxCocoa
import RxSwift

class ISLocationManager : NSObject, CLLocationManagerDelegate {
    static var shared:ISLocationManager = {
        return ISLocationManager()
    }()
    
    var currentLocation = BehaviorRelay<CLLocationCoordinate2D?>(value: nil)
    
    private lazy var locationManager:CLLocationManager = {
        let locationManager = CLLocationManager()
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        
        return locationManager
    }()
    
    func start() {
        locationManager.startUpdatingLocation()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        currentLocation.accept(locations.first?.coordinate)
    }
}
