//
//  ImageLoaderTests.swift
//  ImageLoaderTests
//
//  Created by Mike Nuzzolo on 3/3/25.
//

import XCTest
@testable import Recipes_App

class ImageLoaderTests: XCTestCase {

    override func setUp() {
        // nothing to do here for now
    }
    
    override func tearDown() {
        // nothing to do here for now
    }

    func test_givenImageLoader_verifyInitState() {
        let imageLoader = ImageLoader()
        // Verifiy initial state
        XCTAssertEqual(imageLoader.state, ImageLoader.LoadingState.loading)
        XCTAssertNil(imageLoader.url)
    }
    
    func test_givenImageLoaderWithInvalidUrl_verifyFailedState() async {
        let imageLoader = ImageLoader()
        let testURL = URL(string: "foo")!
        // Verify that when attempting to load an invalid image, we hit the "failure" state
        await imageLoader.fetchImage(url: testURL)
        XCTAssertEqual(imageLoader.state, .failure)
    }
    
    func test_givenImageLoaderWithValidUrl_verifySuccessState() async {
        let imageLoader = ImageLoader()
        let cacheManager = CacheManager.shared
        // Verify that when we load a valid image, we reach the "success" state
        let testURL = URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/535dfe4e-5d61-4db6-ba8f-7a27b1214f5d/small.jpg")!
        await imageLoader.fetchImage(url: testURL)
        let data = try! await cacheManager.load(url: testURL)
        XCTAssertEqual(imageLoader.state, .success(data!))
    }
}
