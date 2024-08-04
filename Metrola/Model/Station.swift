//
//  Station.swift
//  metrola
//
//  Created by Francis Breidenbach on 7/13/24.
//

import Foundation
import SwiftData
import SwiftyJSON

@Model
class Station: Decodable {
  @Attribute(.unique) var id: Int
  var name: String
  var code: Int
  var latitude: Double
  var longitude: Double
  var lineID = [Int]()

  enum CodingKeys: String, CodingKey {
    case id
    case name
    case code
    case latitude = "lat"
    case longitude = "lon"
  }

  init(id: Int, name: String, code: Int, latitude: Double, longitude: Double) {
    self.id = id
    self.name = name
    self.code = code
    self.latitude = latitude
    self.longitude = longitude
  }

  required init(from decoder: any Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    id = try container.decode(Int.self, forKey: .id)
    name = try container.decode(String.self, forKey: .name)
    code = try container.decode(Int.self, forKey: .code)
    latitude = try container.decode(Double.self, forKey: .latitude)
    longitude = try container.decode(Double.self, forKey: .longitude)
  }

  init(forLine line: Int?, fromJSON json: JSON) {
    id = json["id"].intValue
    name = json["name"].stringValue
    code = json["code"].intValue
    latitude = json["lat"].doubleValue
    longitude = json["lon"].doubleValue
    if let line {
      lineID.append(line)
    }
  }

  #if DEBUG
    static let example = Station(
      id: 80122,
      name: "7th Street / Metro Center Station - Metro A & E Lines",
      code: 80122,
      latitude: 34.04861,
      longitude: -118.258822
    )
  #endif
}

// extension Station: Identifiable, Equatable {}
