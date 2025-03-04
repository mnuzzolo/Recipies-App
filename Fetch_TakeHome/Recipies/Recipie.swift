//
//  Recipie.swift
//  Fetch_TakeHome
//
//  Created by Mike Nuzzolo on 3/3/25.
//

import Foundation

struct Recipie: Identifiable, Decodable {
    // The unique identifier for the receipe. Represented as a UUID.
    var id: UUID {
        UUID(uuidString: uuid) ?? UUID()
    }
    let uuid: String
    // The cuisine of the recipe.
    let cuisine: String
    // The name of the recipe.
    let name: String
    // The URL of the recipes’s full-size photo.
    var photo_url_large: URL? = nil
    // The URL of the recipes’s full-size photo. Useful for list view.
    var photo_url_small: URL? = nil
    // The URL of the recipe's original website.
    var source_url: URL? = nil
    // The URL of the recipe's YouTube video.
    var youtube_url: URL? = nil
}
