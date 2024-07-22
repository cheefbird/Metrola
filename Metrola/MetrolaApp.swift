//
//  MetrolaApp.swift
//  Metrola
//
//  Created by Francis Breidenbach on 7/14/24.
//

import SwiftUI
import SwiftData

@main
struct MetrolaApp: App {
    var body: some Scene {
        WindowGroup {
            RootView()
        }
        .modelContainer(for: [Line.self, Station.self])
    }
}
