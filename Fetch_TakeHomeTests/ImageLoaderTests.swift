//
//  ImageLoaderTests.swift
//  ImageLoaderTests
//
//  Created by Mike Nuzzolo on 3/3/25.
//

import XCTest
@testable import Fetch_TakeHome

class ImageLoaderTests: XCTestCase {

    override func setUp() {
        // nothing to do here for now
    }
    
    override func tearDown() {
        // nothing to do here for now
    }

    func test_givenImageLoader_verifyInitState() {
        let imageLoader = ImageLoader()
        XCTAssertEqual(imageLoader.state, ImageLoader.LoadingState.loading)
        XCTAssertNil(imageLoader.url)
    }
    
    func test_givenImageLoaderWithInvalidUrl_verifyFailedState() async {
        let imageLoader = ImageLoader()
        let testURL = URL(string: "foo")!
        await imageLoader.fetchImage(url: testURL)
        XCTAssertEqual(imageLoader.state, .failure)
    }
    
    func test_givenImageLoaderWithValidUrl_verifySuccessState() async {
        let imageLoader = ImageLoader()
        let cacheManager = CacheManager.shared
        let testURL = URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/535dfe4e-5d61-4db6-ba8f-7a27b1214f5d/small.jpg")!
        await imageLoader.fetchImage(url: testURL)
        let data = try! await cacheManager.load(url: testURL)
        XCTAssertEqual(imageLoader.state, .success(data!))
    }
}
