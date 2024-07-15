//
//  LocationManager.swift
//  Voyage
//
//  Created by Inyene Etoedia on 02/07/2024.
//

import CoreLocation

class LocationManagerVM: NSObject, ObservableObject, CLLocationManagerDelegate {
    private var locationManager = CLLocationManager()
    
    override init() {
        super.init()
        locationManager.delegate = self
        //locationManager.requestWhenInUseAuthorization()
    }
    
    func checkLocationIsEnabled(){
        if CLLocationManager.locationServicesEnabled() {
            locationManager = CLLocationManager()
        } else{
            print("Location is not enabled on your device")
        }
    }
    
    func checkLocationAuthorization() {
        
    }
    
    func requestAllowOnceLocationPermission(){
        locationManager.requestLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard locations.first != nil else {
            print("An error occurred")
            return
        }
    }
    

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
    
}
