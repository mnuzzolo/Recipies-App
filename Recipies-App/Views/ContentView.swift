//
//  ContentView.swift
//  Recipies_App
//
//  Created by Mike Nuzzolo on 3/3/25.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var manager = RecipeManager()
    
    var body: some View {
        HStack {
            Text("Recipes")
                .font(.largeTitle)
                .bold()
                .padding()
            Spacer()
        }
        if manager.recipes.count > 0 {
            // Recipe List
            List {
                ForEach(manager.recipes) { recipe in
                    RecipeView(viewModel: RecipeViewModel(recipe))
                }
            }
        } else {
            // Error State
            VStack {
                Spacer()
                if manager.isLoading {
                    ProgressView()
                        .padding()
                    Text("Loading...")
                } else {
                    Text("No recipes were found.")
                    Button("Try Again") {
                        Task {
                            await manager.fetchRecipes()
                        }
                    }
                }
                Spacer()
            }
        }
    }
}

#Preview {
    ContentView()
}
