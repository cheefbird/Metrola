//
//  Station.swift
//  metrola
//
//  Created by Francis Breidenbach on 7/13/24.
//

import Foundation
import SwiftyJSON
import SwiftData

@Model
class Station: Decodable {
    @Attribute(.unique) let id: Int
    let name: String
    let code: Int
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
    
    required init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        code = try container.decode(Int.self, forKey: .code)
        latitude = try container.decode(Double.self, forKey: .latitude)
        longitude = try container.decode(Double.self, forKey: .longitude)
    }
        
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
}

//extension Station: Identifiable, Equatable {}
