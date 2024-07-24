//
//  TestDataView.swift
//  Metrola
//
//  Created by Francis Breidenbach on 7/20/24.
//

import SwiftUI
import SwiftData

struct TestDataView: View {
    @Environment(\.modelContext) var modelContext
    
    @Query var lines: [Line]
    @Query var stations: [Station]
    
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
        }

        .onAppear {
            if try! modelContext.fetchCount(FetchDescriptor<Line>()) < 1 {
                MetroNet.shared.getLines { results in
                    for line in results {
                        modelContext.insert(line)
                    }
                }
            }
            
            if try! modelContext.fetchCount(FetchDescriptor<Station>()) < 1 {
                MetroNet.shared.getStations(forLineID: 801) { results in
                    for station in results {
                        modelContext.insert(station)
                    }
                }
            }
        }
    }
}

#Preview {
    TestDataView()
}
