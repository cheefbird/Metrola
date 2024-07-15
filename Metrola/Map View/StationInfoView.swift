//
//  StationInfoView.swift
//  metrola
//
//  Created by Francis Breidenbach on 7/13/24.
//

import SwiftUI
import MapKit

struct StationInfoView: View {
    @State private var lookAroundScene: MKLookAroundScene?
    
    var selectedStation: MKMapItem
    
    func getLookAroundScene() {
        lookAroundScene = nil
        Task {
            let request = MKLookAroundSceneRequest(mapItem: selectedStation)
            lookAroundScene = try? await request.scene
        }
    }
    
    var body: some View {
        LookAroundPreview(initialScene: lookAroundScene)
            .overlay(alignment: .bottomTrailing) {
                HStack {
                    Text("Station's Name")
                }
                .font(.caption)
                .foregroundStyle(.white)
                .padding(10)
            }
            .onAppear {
                getLookAroundScene()
            }
            .onChange(of: selectedStation) {
                getLookAroundScene()
            }
    }
}

#Preview {
    StationInfoView(selectedStation: MKMapItem())
}
