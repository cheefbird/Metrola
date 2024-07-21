//
//  LineBrowserView.swift
//  Metrola
//
//  Created by Francis Breidenbach on 7/20/24.
//

import SwiftUI

struct LineBrowserView: View {
    @State private var lines = [Line]()
    var body: some View {
        NavigationStack {
            List(lines) {
                Text($0.name)
            }
        }
        .onAppear {
            MetroNet.shared.getLines { lines in
                self.lines = lines
            }
        }
    }
}

#Preview {
    LineBrowserView()
}
