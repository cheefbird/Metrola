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

  @Query(sort: \Line.name) var lines: [Line]

//    @Binding var selectedLine: Line

  @State private var typeSelection = "Lines"

  let types = ["Lines", "Stations"]

  private var gridItemLayout = [GridItem(.flexible())]

  var body: some View {
    VStack(spacing: 0) {
      Group {
        Picker("Options", selection: $typeSelection) {
          ForEach(types, id: \.self) {
            Text($0)
          }
        }
        .pickerStyle(.segmented)
      }
      Group {
        ScrollView(.vertical, showsIndicators: false) {
          LazyVGrid(columns: gridItemLayout, alignment: .center, spacing: 15) {
            ForEach(lines) { line in
              Button {
                print("button pressed")
              } label: {
                HStack {
                  Image("railLine/\(line.id)")
                    .resizable()
                    .font(.system(size: 30))
                    .frame(width: 75, height: 75)

                  Text(line.name)
                    .font(.title)
                    .foregroundStyle(.black)
                }
                .padding(.horizontal)
                .background(Color.eggWhite)
                .cornerRadius(10)
              }
            }
          }
        }
        .padding(.top, 10)
      }
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
