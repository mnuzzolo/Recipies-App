//
//  ContentView.swift
//  Recipe_App
//
//  Created by Mike Nuzzolo on 3/3/25.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var manager = RecipeManager()
    
    var body: some View {
        if manager.recipes.count > 0 {
            // Recipe List
            NavigationStack {
                List {
                    ForEach(manager.recipes) { recipe in
                        NavigationLink {
                            RecipeDetailView(viewModel: RecipeViewModel(recipe))
                        } label: {
                            RecipeView(viewModel: RecipeViewModel(recipe))
                        }
                        
                    }
                }
                .navigationTitle("Recipes")
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
