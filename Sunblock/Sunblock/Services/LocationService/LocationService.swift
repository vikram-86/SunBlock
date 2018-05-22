//
//  LocationService.swift
//  Sunblock
//
//  Created by Suthananth Arulanatham on 13.05.2018.
//  Copyright © 2018 Shortcut. All rights reserved.
//

import UIKit
import CoreLocation

protocol LocationServiceDelegate: class{
    func locationServiceDidFinish(with location: UserLocation)
    func locationServiceDidFinishWithError(_ error: LocationError)
    func permissionChanged(_ permission: PermissionStatus)
}

enum PermissionStatus{
    case granted
    case noGranted
}

class LocationService: NSObject{

    static let current = LocationService()

    private var locationManager: CLLocationManager!
    lazy private var geoCoder	= CLGeocoder()
    weak var delegate: LocationServiceDelegate?


    override init() {
        super.init()
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }

    func requestAuthorization(){
        if !CLLocationManager.locationServicesEnabled(){
            // User has turned of Location service in Settings
            delegate?.locationServiceDidFinishWithError(.permissionDisabled)
            return
        }

        if (CLLocationManager.authorizationStatus() == .authorizedWhenInUse){
            // User has authorized Location Service
            delegate?.locationServiceDidFinishWithError(.permissionGranted)
            return
        }

        if (CLLocationManager.authorizationStatus() != .notDetermined){
            delegate?.locationServiceDidFinishWithError(.permissionDenied)
            return
        }

        locationManager.requestWhenInUseAuthorization()
    }

    func requestLocation(){
        if CLLocationManager.authorizationStatus() != .authorizedWhenInUse{
            requestAuthorization()
        }else{
            locationManager.startUpdatingLocation()
        }
    }
}

extension LocationService: CLLocationManagerDelegate{

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard
        	let userLocation = locations.first
        else{ return }
        let altitude = userLocation.altitude
        manager.stopUpdatingLocation()
        geoCoder.reverseGeocodeLocation(userLocation) { (placemarks, error) in
            if let error = error {
                print(error)
            }else{
                if let placemarks = placemarks, let placemark = placemarks.first,
                    let city = placemark.locality, let country = placemark.country{

                    let coordinate = UserCoordinate(latitude: Float(userLocation.coordinate.latitude),
                                                    longitude: Float(userLocation.coordinate.longitude))
                    let userLocation = UserLocation(cityName: city, country: country, coordinate: coordinate, altitude: Float(altitude))
                    self.delegate?.locationServiceDidFinish(with: userLocation)
                }
            }
        }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        delegate?.locationServiceDidFinishWithError(.notDetermined("Could not locate you location, please try again later"))

    }

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse{
            delegate?.permissionChanged(.granted)
        }else{
            delegate?.permissionChanged(.noGranted)
        }
    }
}
