//
//  Stop.swift
//  metrola
//
//  Created by Francis Breidenbach on 7/13/24.
//

import Foundation
import MapKit

struct Stop: Codable, Hashable, Identifiable {
    var id: String
    var name: String
    var code: Int
    var latitude: Double
    var longitude: Double
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case code
        case latitude = "lat"
        case longitude = "lon"
    }
    
    lazy var coordinates: CLLocationCoordinate2D = {
        return CLLocationCoordinate2D(latitude: self.latitude, longitude: self.longitude)
    }()
}


