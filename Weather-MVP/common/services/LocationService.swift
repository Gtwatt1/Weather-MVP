//
//  LocationService.swift
//  Weather
//
//  Created by Godwin Olorunshola on 11/12/2019.
//  Copyright © 2019 Godwin Olorunshola. All rights reserved.
//

import Foundation
import CoreLocation

protocol  LocationServiceDelegate {
    func didGetLocation(_ lat : CLLocationDegrees, lng : CLLocationDegrees)
    func locationdidFail(_ reason : String)
}

class LocationService : NSObject{
    var delegate : LocationServiceDelegate?
    let locationManager = CLLocationManager()

    override init() {
        super.init()
        self.locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        }
    }
    
    func startLocationRequest(){
        locationManager.startUpdatingLocation()
    }
}

extension LocationService : CLLocationManagerDelegate{
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        delegate?.didGetLocation(locValue.latitude, lng: locValue.longitude)
    }
    
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
//        delegate?.locationdidFail(error.localizedDescription)
        delegate?.locationdidFail("There was an error getting your location")

    }
}
