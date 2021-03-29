//
//  LocationManager.swift
//  Mockup
//
//  Created by Vladislav Erchik on 10.12.20.
//

import Foundation
import CoreLocation
import Combine

class LocationManager: NSObject {
    static var shared = LocationManager()
    
    private let manager = CLLocationManager()
    
    private override init() {
        super.init()
        manager.requestWhenInUseAuthorization()
        manager.delegate = self
        manager.startUpdatingLocation()
        
        locationPublisher.send(manager.location?.coordinate)
    }
    
    var locationPublisher = CurrentValueSubject<CLLocationCoordinate2D?, Never>(nil)
    var currentLocation: CLLocationCoordinate2D? {
        manager.location?.coordinate
    }
}

extension LocationManager: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        print("[LOCATION] Status changed: \(status.rawValue)")
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let lastLocation = locations.last else { return }
        
        print("[LOCATION] Location updated: \(lastLocation.coordinate)")
        locationPublisher.send(manager.location?.coordinate)
    }
}
