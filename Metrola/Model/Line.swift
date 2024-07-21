//
//  Line.swift
//  metrola
//
//  Created by Francis Breidenbach on 7/8/24.
//

import Foundation
import SwiftyJSON

/// Note: Appears as "route" from source API
struct Line {
    var id: Int
    var name: String
    var color: String
    var type: Int
    var directions = [String: String]()
    
    /// Create Line from JSON type.
    init(fromJSON json: JSON) {
        self.id = json["id"].intValue
        self.name = json["name"].stringValue
        let rawColor = json["color"].stringValue
        self.color = "#\(rawColor)"
        self.type = json["type"].intValue
    }
}

extension Line: Identifiable, Equatable {}
