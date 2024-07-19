//
//  LineListView.swift
//  Metrola
//
//  Created by Francis Breidenbach on 7/19/24.
//

import SwiftData
import SwiftUI

struct LineListView: View {
    @Environment(\.modelContext) private var modelContext
    
    @Query var lines: [Line]

    var body: some View {
        List {
            ForEach(lines) { line in
                Text(line.name)
            }
        }
        .onAppear(perform: {
            try! loadLines()
        })
    }

    private func loadLines() throws {
        if lines.count > 0 {
            return
        }

        do {
            guard let url = Bundle.main.url(forResource: "railLines", withExtension: "json") else {
                fatalError("Failed getting the file URL for railLines.json")
            }
            let data = try Data(contentsOf: url)
            let newLines = try JSONDecoder().decode([Line].self, from: data)
            for line in newLines {
                modelContext.insert(line)
            }
        } catch {
            print("failed creating new Lines")
        }
    }
}

#Preview {
    LineListView()
}
