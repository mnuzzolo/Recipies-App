//
//  RecipeViewModel.swift
//  Recipies_App
//
//  Created by Mike Nuzzolo on 3/5/25.
//

import Foundation

public class RecipeViewModel: ObservableObject {
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
}
