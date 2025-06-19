//
//  RecipeViewModel.swift
//  Recipes_App
//
//  Created by Mike Nuzzolo on 3/5/25.
//

import Foundation

public struct RecipeViewModel {
    private let recipe: Recipe
    
    init(_ recipe: Recipe) {
        self.recipe = recipe
    }
    
    // Title to display in the view
    public var title: String {
        recipe.name
    }
    
    // Subtitle to display in the view
    public var subtitle: String {
        recipe.cuisine
    }
    
    // Details paragraph to display in the view
    public var details: String {
        recipe.details ?? .placeholderDetails
    }
    
    // Link to the recipe page
    public var moreInfo: URL? {
        recipe.source_url
    }
    
    // Whether to show a link out to the recipe page
    public var hasMoreInfo: Bool {
        recipe.source_url != nil
    }
    
    // Small image URL - to use in the list view
    public var smallImageURL: URL? {
        recipe.photo_url_small
    }
    
    // Large image URL - to use in the list view
    public var largeImageURL: URL? {
        recipe.photo_url_large
    }
}
