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
            
            LineListView()
                .padding(.horizontal, 10)
                .background(.blue)
                .tabItem {
                    Image(systemName: "house.and.flag.circle")
                    Text("Stations")
                }
            
            Text("TODO: User Setings")
                .padding(.horizontal, 10)
                .background(.green)
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
