//
//  MapViewModel.swift
//  MapLocation
//
//  Created by Farkhod on 24.10.2021.
//

import MapKit

enum MapDetails {
    static let defaultLocation = CLLocationCoordinate2D(latitude: 51.507351, longitude: -0.127696)
    static let defaultSpan = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
}

final class MapViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    @Published var region = MKCoordinateRegion(
        center: MapDetails.defaultLocation,
        span: MapDetails.defaultSpan
    )
    
    var locationManager: CLLocationManager?
    
    func checkIsLocationServiceEnabled() {
        if (CLLocationManager.locationServicesEnabled()) {
            locationManager = CLLocationManager()
            locationManager!.delegate = self
        } else {
            print("Location access error!")
        }
    }
    
    private func checkLocationAuthorization() {
        guard let locationManager = locationManager else { return }
        
        switch locationManager.authorizationStatus {
            case .notDetermined:
                locationManager.requestWhenInUseAuthorization()
            case .restricted:
                print("Your location is restricted!")
            case .denied:
                print("Your location not permitted!")
            case .authorizedAlways, .authorizedWhenInUse:
                guard let coordinates = locationManager.location?.coordinate else { return }
            
                region = MKCoordinateRegion(
                    center: coordinates, span: MapDetails.defaultSpan
                )
            @unknown default:
                break
        }
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocationAuthorization()
    }
}
