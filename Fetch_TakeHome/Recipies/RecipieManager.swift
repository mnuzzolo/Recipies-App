//
//  RecipieManager.swift
//  Fetch_TakeHome
//
//  Created by Mike Nuzzolo on 3/3/25.
//

import Foundation

extension String {
    // This endpoint returns all recipies to display
    static let allRecipiesURL = "https://d3jbb8n5wk0qxi.cloudfront.net/recipes.json"
    // This endpoint returns invalid data (for testing)
    static let malformedDataURL = "https://d3jbb8n5wk0qxi.cloudfront.net/recipes-malformed.json"
    // This endpoint returns empty data (for testing)
    static let emptyDataURL = "https://d3jbb8n5wk0qxi.cloudfront.net/recipes-empty.json"
}

public final class RecipieManager: ObservableObject {
    // The fetched list of recipies
    @Published private(set) var recipies: [Recipie] = []
    private var url: URL?
    
    public var isLoading: Bool = true
    
    init(endpoint: String = .allRecipiesURL) {
        if let url = URL(string: endpoint) {
            self.url = url
            Task {
                await fetchRecipies()
            }
        } else {
            // Failed to create a valid URL object
            recipies = []
        }
    }
    
    @MainActor
    func fetchRecipies() async {
        // Clear existing list
        recipies = []
        
        guard let url = url else {
            isLoading = false
            return
        }

        do {
            // Fetch and decode recipies list from the endpoint
            var request = URLRequest(url: url)
            request.cachePolicy = .returnCacheDataElseLoad
            let (data, _) = try await URLSession.shared.data(for: request)
            let decoder = JSONDecoder()
            let decodedData = try decoder.decode(Dictionary<String, [Recipie]>.self, from: data)
            if let result = decodedData["recipes"] {
                // Update with sorted list (alphabetically by name)
                self.recipies = result.sorted { $0.name < $1.name }
                isLoading = false
            }
        } catch {
            print("Fetching error: \(error)")
            isLoading = false
        }
    }
}
