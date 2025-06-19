//
//  String+RecipeManager.swift
//  Recipies-App
//
//  Created by Mike Nuzzolo on 6/19/25.
//

extension String {
    // This endpoint returns all recipes to display
    static let allRecipesURL = "https://d3jbb8n5wk0qxi.cloudfront.net/recipes.json"
    // This endpoint returns invalid data (for testing)
    static let malformedDataURL = "https://d3jbb8n5wk0qxi.cloudfront.net/recipes-malformed.json"
    // This endpoint returns empty data (for testing)
    static let emptyDataURL = "https://d3jbb8n5wk0qxi.cloudfront.net/recipes-empty.json"
}
