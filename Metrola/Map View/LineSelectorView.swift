//
//  LineSelectorView.swift
//  Metrola
//
//  Created by Francis Breidenbach on 7/23/24.
//

import SwiftData
import SwiftUI

struct LineSelectorView: View {
    @Environment(\.modelContext) var modelContext

    @Query var lines: [Line]

    @State private var typeSelection = "Lines"

    let types = ["Lines", "Stations"]

    private var gridItemLayout = [GridItem(.flexible())]

    var body: some View {
        VStack {
            Section {
                Picker("Options", selection: $typeSelection) {
                    ForEach(types, id: \.self) {
                        Text($0)
                    }
                }
                .pickerStyle(.segmented)
                .padding(.top, 15)
            }
            ScrollView(.horizontal, showsIndicators: true) {
                LazyHGrid(rows: gridItemLayout, spacing: 15) {
                    ForEach(lines) {
                        Image("railLine/\($0.id)")
                            .resizable()
                            .font(.system(size: 30))
                            .frame(width: 50, height: 50)
                            .background(Color.eggWhite)
                            .cornerRadius(10)
                    }
                }
                
            }
            Spacer()
        }
    }
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Line.self, configurations: config)

    let stations = Bundle.main.decode([Line].self, from: "testLines.json")
    for station in stations {
        container.mainContext.insert(station)
    }
    return LineSelectorView().modelContainer(container)
}
