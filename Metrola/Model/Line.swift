//
//  Line.swift
//  metrola
//
//  Created by Francis Breidenbach on 7/8/24.
//

import SwiftData

/// Note: Appears as "route" from source API
@Model class Line: Decodable {
    @Attribute(.unique) var id: String
    var name: String
    var color: String
    var type: String
    
    init(id: String, name: String, color: String, type: String) {
        self.id = id
        self.name = name
        self.color = color
        self.type = type
    }
    
    required init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        color = try container.decode(String.self, forKey: .color)
        type = try container.decode(String.self, forKey: .type)
    }
    
    enum CodingKeys: CodingKey {
        case id
        case name
        case color
        case type
    }
    
    func getImage() -> String {
        switch self.id {
        case "801":
            return "railLine/a"
        case "802":
            return "railLine/b"
        case "803":
            return "railLine/c"
        case "805":
            return "railLine/d"
        case "804":
            return "railLine/e"
        case "807":
            return "railLine/k"
        default:
            return ""
        }
    }
}
