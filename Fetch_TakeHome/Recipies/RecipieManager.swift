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
            fetchRecipies()
        } else {
            // Failed to create a valid URL object
            recipies = []
        }
    }
    
    func fetchRecipies() {
        guard let url = url else {
            return
        }

        var request = URLRequest(url: url)
        request.cachePolicy = .returnCacheDataElseLoad
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                return
            }
            
            let decoder = JSONDecoder()
            do {
                let decodedData = try decoder.decode(Dictionary<String, [Recipie]>.self, from: data)
                if let result = decodedData["recipes"] {
                    Task { @MainActor in
                        self.recipies = result.sorted { $0.name < $1.name }
                    }
                }
            } catch {
                print("Decoding Error: \(error)")
            }
        }
        task.resume()
    }
}
