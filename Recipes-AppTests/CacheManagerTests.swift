//
//  CacheManagerTests.swift
//  Recipes_App
//
//  Created by Mike Nuzzolo on 3/4/25.
//

import XCTest
@testable import Recipes_App

class CacheManagerTests: XCTestCase {
    
    override func setUp() {
        // nothing to do here for now
    }
    
    override func tearDown() {
        // nothing to do here for now
    }
    
    func test_givenCacheManager_verifyInitState() {
        let cacheManager = CacheManager.shared
        let testURL = "foo"
        // Verify the init state of the cache
        let data = cacheManager.cache.object(forKey: testURL as NSString)
        XCTAssertNil(data)
    }
    
    func test_givenCacheManager_verifyCacheUpdates() async {
        let cacheManager = CacheManager.shared
        let testURL = "https://d3jbb8n5wk0qxi.cloudfront.net/photos/535dfe4e-5d61-4db6-ba8f-7a27b1214f5d/small.jpg"
        // Call load on our test URL
        let data = try! await cacheManager.load(url: URL(string: testURL)!)
        XCTAssertNotNil(data)
        // Verify that the cache contains the same data we just loaded
        let cachedData = cacheManager.cache.object(forKey: testURL as NSString)
        XCTAssertEqual(data as? NSData, cachedData)
    }
}
