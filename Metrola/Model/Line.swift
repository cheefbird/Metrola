//
//  Line.swift
//  metrola
//
//  Created by Francis Breidenbach on 7/8/24.
//

import Foundation
import SwiftData
import SwiftyJSON

/// Note: Appears as "route" from source API
@Model
class Line: Decodable {
  @Attribute(.unique) var id: Int
  var name: String
  var color: String
  var type: Int
//    var stations = [Station]()

  enum CodingKeys: String, CodingKey {
    case id
    case name
    case color
    case type
  }

  required init(from decoder: any Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    id = try container.decode(Int.self, forKey: .id)
    name = try container.decode(String.self, forKey: .name)
    let preColor = try container.decode(String.self, forKey: .color)
    color = "#\(preColor)"
    type = try container.decode(Int.self, forKey: .type)
  }

  /// Create Line from JSON type.
  init(fromJSON json: JSON) {
    id = json["id"].intValue
    name = json["name"].stringValue
    let rawColor = json["color"].stringValue
    color = "#\(rawColor)"
    type = json["type"].intValue
  }
}

extension Line: Identifiable, Equatable {
  static func == (lhs: Line, rhs: Line) -> Bool {
    return lhs.id == rhs.id
  }
}
