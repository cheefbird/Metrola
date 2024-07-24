//
//  Line.swift
//  metrola
//
//  Created by Francis Breidenbach on 7/8/24.
//

import Foundation
import SwiftyJSON
import SwiftData

/// Note: Appears as "route" from source API
@Model
class Line {
    @Attribute(.unique) let id: Int
    let name: String
    let color: String
    let type: Int
//    var stations = [Station]()
    
    /// Create Line from JSON type.
    init(fromJSON json: JSON) {
        self.id = json["id"].intValue
        self.name = json["name"].stringValue
        let rawColor = json["color"].stringValue
        self.color = "#\(rawColor)"
        self.type = json["type"].intValue
    }
}

extension Line: Identifiable, Equatable {
    static func == (lhs: Line, rhs: Line) -> Bool {
        return lhs.id == rhs.id
    }
}
