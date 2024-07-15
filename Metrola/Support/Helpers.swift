//
//  Helpers.swift
//  metrola
//
//  Created by Francis Breidenbach on 7/13/24.
//

import Foundation
import MapKit

extension Bundle {
    func decode<T: Decodable>(_ type: T.Type, from file: String) -> T {
        guard let url = url(forResource: file, withExtension: nil) else {
            fatalError("Failed to locate \(file) in bundle.")
        }

        guard let data = try? Data(contentsOf: url) else {
            fatalError("Failed to load \(file) from bundle.")
        }

        let decoder = JSONDecoder()

        guard let loaded = try? decoder.decode(T.self, from: data) else {
            fatalError("Failed to decode \(file) from bundle.")
        }

        return loaded
    }
}

func stopCoordinates(for stop: Stop) -> CLLocationCoordinate2D {
    return CLLocationCoordinate2D(latitude: stop.latitude, longitude: stop.longitude)
}
