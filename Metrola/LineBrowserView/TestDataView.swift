//
//  TestDataView.swift
//  Metrola
//
//  Created by Francis Breidenbach on 7/20/24.
//

import SwiftUI

struct TestDataView: View {
    @State private var lines = [Line]()
    @State private var stations = [Station]()
    @State private var selectedPage = "Lines"

    let pages = ["Lines", "Stations"]

    var body: some View {
        NavigationStack {
            List {
                Section {
                    Picker("Pages", selection: $selectedPage) {
                        ForEach(pages, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(.segmented)
                }
                
                Section {
                        if selectedPage == "Stations" {
                            ForEach(stations) {
                                Text($0.name)
                            }
                        } else {
                            ForEach(lines) {
                                Text($0.name)
                            }
                        }
                }
            }
            .toolbar {
                
            }
        }

        .onAppear {
            MetroNet.shared.getLines { lines in
                self.lines = lines
            }
            MetroNet.shared.getStations(forLineID: 801) { stations in
                self.stations = stations
            }
        }
    }
}

#Preview {
    TestDataView()
}
