//
//  StationMapView.swift
//  metrola
//
//  Created by Francis Breidenbach on 7/12/24.
//

import MapKit
import SwiftUI

extension MKCoordinateRegion {
    static let losAngeles = MKCoordinateRegion(
        center: CLLocationCoordinate2D(
            latitude: 34.04869,
            longitude: -118.25864),
        span: MKCoordinateSpan(
            latitudeDelta: 0.1,
            longitudeDelta: 0.1))
}

struct StationMapView: View {
    @StateObject var locationManager = LocationManager()

    @State private var position: MapCameraPosition = .automatic
    @State private var visibleRegion: MKCoordinateRegion?
    @State private var selectedStation: MKMapItem?
    @State private var stations = [Station]()

    var body: some View {
        Map(position: $position, selection: $selectedStation) {
            ForEach(stations) { stop in
                Annotation(stop.name, coordinate: stopCoordinates(for: stop)) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 5)
                            .fill(Color("oldYellow"))
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(.secondary, lineWidth: 5)
                        Image(systemName: "lightrail")
                            .padding(5)
                    }
                }
            }
        }
        .mapStyle(.standard(elevation: .realistic))
        .mapControls {
            MapUserLocationButton()
                
        }
        .tint(Color.seaGreen)
        .onChange(of: stations) {
            position = .automatic
        }
        .onMapCameraChange { context in
            visibleRegion = context.region
        }
        
    }
}

#Preview {
    StationMapView()
}
