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
            return
        }

        var request = URLRequest(url: url)
        request.cachePolicy = .returnCacheDataElseLoad
        
        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            let decoder = JSONDecoder()
            let decodedData = try decoder.decode(Dictionary<String, [Recipie]>.self, from: data)
            if let result = decodedData["recipes"] {
                self.recipies = result.sorted { $0.name < $1.name }
            }
        }
        catch {
            print("Fetching error: \(error)")
        }
    }
}
