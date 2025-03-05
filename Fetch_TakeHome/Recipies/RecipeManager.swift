//
//  RecipeManager.swift
//  Fetch_TakeHome
//
//  Created by Mike Nuzzolo on 3/3/25.
//

import Foundation

extension String {
    // This endpoint returns all recipes to display
    static let allRecipesURL = "https://d3jbb8n5wk0qxi.cloudfront.net/recipes.json"
    // This endpoint returns invalid data (for testing)
    static let malformedDataURL = "https://d3jbb8n5wk0qxi.cloudfront.net/recipes-malformed.json"
    // This endpoint returns empty data (for testing)
    static let emptyDataURL = "https://d3jbb8n5wk0qxi.cloudfront.net/recipes-empty.json"
}

public final class RecipeManager: ObservableObject {
    // The fetched list of recipes
    @Published private(set) var recipes: [Recipe] = []
    private var url: URL?
    
    public var isLoading: Bool = true
    
    init(endpoint: String = .allRecipesURL) {
        if let url = URL(string: endpoint) {
            self.url = url
            Task {
                await fetchRecipes()
            }
        } else {
            // Failed to create a valid URL object
            recipes = []
        }
    }
    
    @MainActor
    func fetchRecipes() async {
        // Clear existing list
        recipes = []
        
        guard let url = url else {
            isLoading = false
            return
        }

        do {
            // Fetch and decode recipes list from the endpoint
            var request = URLRequest(url: url)
            request.cachePolicy = .returnCacheDataElseLoad
            let (data, _) = try await URLSession.shared.data(for: request)
            let decoder = JSONDecoder()
            let decodedData = try decoder.decode(Dictionary<String, [Recipe]>.self, from: data)
            if let result = decodedData["recipes"] {
                // Update with sorted list (alphabetically by name)
                self.recipes = result.sorted { $0.name < $1.name }
                isLoading = false
            }
        } catch {
            print("Fetching error: \(error)")
            isLoading = false
        }
    }
}
