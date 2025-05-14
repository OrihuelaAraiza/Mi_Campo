//
//  LocationManager.swift
//  Mi Campo
//
//  Created by Juan Pablo Orihuela Araiza on 12/05/25.
//

import CoreLocation
import SwiftUI

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    private let manager = CLLocationManager()

    @Published var userLocation: CLLocation?
    @Published var permissionGranted: Bool = false

    override init() {
        super.init()
        manager.delegate = self
        checkPermission()
    }

    func requestPermission() {
        manager.requestWhenInUseAuthorization()
    }

    func checkPermission() {
        let status = manager.authorizationStatus
        switch status {
        case .authorizedWhenInUse, .authorizedAlways:
            permissionGranted = true
            manager.requestLocation()
        default:
            permissionGranted = false
        }
    }

    func reset() {
        permissionGranted = false
        userLocation = nil
    }

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        checkPermission()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        userLocation = locations.first
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Ubicación error: \(error.localizedDescription)")
    }
}
