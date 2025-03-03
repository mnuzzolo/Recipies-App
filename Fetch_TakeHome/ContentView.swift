//
//  ContentView.swift
//  Fetch_TakeHome
//
//  Created by Mike Nuzzolo on 3/3/25.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var items: [Item]

    var body: some View {
        List {
            ForEach(items) { item in
                NavigationLink {
                    Text("Item at \(item.timestamp, format: Date.FormatStyle(date: .numeric, time: .standard))")
                } label: {
                    Text(item.timestamp, format: Date.FormatStyle(date: .numeric, time: .standard))
                }
            }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}
