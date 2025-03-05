//
//  RecipeViewModelTests.swift
//  Fetch_TakeHome
//
//  Created by Mike Nuzzolo on 3/5/25.
//

import XCTest
@testable import Fetch_TakeHome

class RecipeViewModelTests: XCTestCase {
    
    override func setUp() {
        // nothing to do here for now
    }
    
    override func tearDown() {
        // nothing to do here for now
    }
 
    func test_givenRecipeViewModel_verifyProperties() {
        let recipe = Recipe(uuid: "uuid",
                            cuisine: "British",
                            name: "Bakewell Tart",
                            photo_url_small: URL(filePath: "imageURL")!,
                            source_url: URL(filePath: "sourceURL")!)
        let viewModel = RecipeViewModel(recipe)
        
        // Verify properties match what we expect
        XCTAssertEqual(recipe.name, viewModel.title)
        XCTAssertEqual(recipe.cuisine, viewModel.subtitle)
        XCTAssertEqual(recipe.photo_url_small, viewModel.smallImageURL)
        XCTAssertEqual(recipe.source_url, viewModel.moreInfo)
        XCTAssertEqual(recipe.source_url != nil, viewModel.hasMoreInfo)
    }
}
