//
//  LocationManager.swift
//  metrola
//
//  Created by Francis Breidenbach on 7/12/24.
//

import Foundation
import MapKit

final class LocationManager: NSObject, ObservableObject {
    private let locationManager = CLLocationManager()

    @Published var region = MKCoordinateRegion(
        center: .init(latitude: 34.04869, longitude: -118.25864),
        span: .init(latitudeDelta: 0.1, longitudeDelta: 0.2)
    )

    override init() {
        super.init()

        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        setup()
    }

    private func setup() {
        switch locationManager.authorizationStatus {
        case .authorizedWhenInUse:
            locationManager.requestLocation()
        case .notDetermined:
            locationManager.startUpdatingLocation()
            locationManager.requestWhenInUseAuthorization()
        case .denied, .restricted:
            print(
                "Must be manually set again due to auth status: \(locationManager.authorizationStatus)"
            )
        default:
            break
        }
    }
}

extension LocationManager: CLLocationManagerDelegate {
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        guard manager.authorizationStatus == .authorizedWhenInUse
        else { return }
        locationManager.requestLocation()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        locations.last.map {
            region = MKCoordinateRegion(
                center: $0.coordinate,
                span: .init(
                    latitudeDelta: 0.01,
                    longitudeDelta: 0.01
                )
            )
        }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: any Error) {
        print(error)
    }
}
