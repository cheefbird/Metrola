//
//  Station.swift
//  metrola
//
//  Created by Francis Breidenbach on 7/13/24.
//

import Foundation
import MapKit
import SwiftyJSON

struct Station {
    let id: Int
    let name: String
    let code: Int
    let latitude: Double
    let longitude: Double
    var lineID = [Int]()
    
    init(forLine line: Int? , fromJSON json: JSON) {
        self.id = json["id"].intValue
        self.name = json["name"].stringValue
        self.code = json["code"].intValue
        self.latitude = json["lat"].doubleValue
        self.longitude = json["lon"].doubleValue
        if let line {
            self.lineID.append(line)
        }
    }
    
    lazy var coordinates: CLLocationCoordinate2D = {
        return CLLocationCoordinate2D(latitude: self.latitude, longitude: self.longitude)
    }()
}

extension Station: Identifiable, Equatable {}
