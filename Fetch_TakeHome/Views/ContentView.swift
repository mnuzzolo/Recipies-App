//
//  ContentView.swift
//  Fetch_TakeHome
//
//  Created by Mike Nuzzolo on 3/3/25.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var manager = RecipieManager()
    
    var body: some View {
        HStack {
            Text("Recipies")
                .font(.largeTitle)
                .bold()
                .padding()
            Spacer()
        }
        if manager.recipies.count > 0 {
            // Recipie List
            List {
                ForEach(manager.recipies) { recipie in
                    RecipieView(recipie: recipie)
                }
            }
        } else {
            // Error State
            VStack {
                Text("No recipies were found.")
                Button("Try Again") {
                    manager.fetchRecipies()
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
