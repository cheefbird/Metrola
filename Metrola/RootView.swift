//
//  ContentView.swift
//  metrola
//
//  Created by Francis Breidenbach on 7/5/24.
//

import SwiftUI

struct RootView: View {
    var body: some View {
        TabView {
            StationMapView()
                .tabItem {
                    Image(systemName: "map.circle")
                    Text("Map View")
                }
            
            TestDataView()
                .tabItem {
                    Image(systemName: "network")
                    Text("Lines")
                }
            
            Text("TODO: User Setings")
                .tabItem {
                    Image(systemName: "gearshape")
                    Text("Settings")
                }
        }
    }
}

#Preview {
    RootView()
}
