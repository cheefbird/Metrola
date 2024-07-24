//
//  StationMapView.swift
//  metrola
//
//  Created by Francis Breidenbach on 7/12/24.
//

import MapKit
import SwiftData
import SwiftUI

extension MKCoordinateRegion {
    static let losAngeles = MKCoordinateRegion(
        center: CLLocationCoordinate2D(
            latitude: 34.04869,
            longitude: -118.25864
        ),
        span: MKCoordinateSpan(
            latitudeDelta: 0.3,
            longitudeDelta: 0.3
        )
    )
}

struct StationMapView: View {
    @Environment(\.modelContext) var modelContext
    @StateObject var locationManager = LocationManager()

    @Query var stations: [Station]

    @State private var position: MapCameraPosition = .region(.losAngeles)
    @State private var visibleRegion: MKCoordinateRegion?
    @State private var selectedStation: MKMapItem?

    var body: some View {
        Map(
            position: $position,
            interactionModes: [.pan, .zoom, .pitch],
            selection: $selectedStation
        ) {
            ForEach(stations) { station in
                Annotation(station.name, coordinate: stationCoordinates(for: station)) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 5)
                            .fill(Color("oldYellow"))
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(.secondary, lineWidth: 1)
                        Image("railLine/a")
                            .resizable()
                            .frame(maxWidth: 20, maxHeight: 20)
                            .scaledToFit()

                    }
                }
            }
//            let coordinates = coordinatesArray()
//
//            MapPolyline(coordinates: coordinates, contourStyle: .geodesic)
//                .stroke(.oldYellow, lineWidth: 5)
        }
        .mapStyle(.standard(elevation: .realistic))
        .mapControls {
            MapUserLocationButton()
        }
        .onMapCameraChange { context in
            visibleRegion = context.region
            position = .region(context.region)
        }
    }

    func coordinatesArray() -> [CLLocationCoordinate2D] {
        var coordinates = [CLLocationCoordinate2D]()
        for station in stations {
            coordinates.append(stationCoordinates(for: station))
        }
        return coordinates
    }
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Station.self, configurations: config)

    let stations = Bundle.main.decode([Station].self, from: "testStops.json")
    for station in stations {
        container.mainContext.insert(station)
    }
    return StationMapView().modelContainer(container)
}
