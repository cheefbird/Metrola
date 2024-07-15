//
//  Line.swift
//  metrola
//
//  Created by Francis Breidenbach on 7/8/24.
//

import Foundation

/// Note: Appears as "route" from source API
struct Line {
    var id: String
    var name: String
    var color: String
    var type: String
    var directions = [String: Any]()
}
