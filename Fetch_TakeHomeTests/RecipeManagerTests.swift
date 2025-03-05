//
//  RecipeManagerTests.swift
//  Fetch_TakeHome
//
//  Created by Mike Nuzzolo on 3/5/25.
//

import XCTest
@testable import Fetch_TakeHome

class RecipeManagerTests: XCTestCase {
    
    override func setUp() {
        // nothing to do here for now
    }
    
    override func tearDown() {
        // nothing to do here for now
    }
    
    func test_givenAllRecipeEndpoint_verifyListIsReturned() async {
        let manager = RecipeManager(endpoint: .allRecipesURL)
        XCTAssertTrue(manager.isLoading)
        await manager.fetchRecipes()
        XCTAssertFalse(manager.isLoading)
        XCTAssertTrue(manager.recipes.count > 0)
    }
    
    func test_givenEmptyRecipeEndpoint_verifyNoListIsReturned() async {
        let manager = RecipeManager(endpoint: .emptyDataURL)
        XCTAssertTrue(manager.isLoading)
        await manager.fetchRecipes()
        XCTAssertFalse(manager.isLoading)
        XCTAssertTrue(manager.recipes.count == 0)
    }
    
    func test_givenMalformedRecipeEndpoint_verifyNoListIsReturned() async {
        let manager = RecipeManager(endpoint: .emptyDataURL)
        XCTAssertTrue(manager.isLoading)
        await manager.fetchRecipes()
        XCTAssertFalse(manager.isLoading)
        XCTAssertTrue(manager.recipes.count == 0)
    }
}
