//
//  RecipeView.swift
//  Fetch_TakeHome
//
//  Created by Mike Nuzzolo on 3/3/25.
//

import SwiftUI

extension CGFloat {
    static let imageSize = 64.0
}

struct RecipeView: View {
    @Environment(\.openURL) var openURL

    let recipe: Recipe

    var body: some View {
        HStack {
            imageView
            metadataView
            chevronView
        }
    }
    
    @ViewBuilder
    var imageView: some View {
        CachedAsyncImage(url: recipe.photo_url_small) { phase in
            switch phase {
            case .empty:
                ProgressView()
            case .success(let image):
                image.resizable()
                    .aspectRatio(contentMode: .fit)
            default:
                Image(systemName: "photo")
            }
        }
        .frame(maxWidth: .imageSize, maxHeight: .imageSize)
    }
    
    @ViewBuilder
    var metadataView: some View {
        VStack {
            HStack {
                Text(recipe.name)
                    .bold()
                    .lineLimit(1)
                Spacer()
            }
            HStack {
                Text(recipe.cuisine)
                    .lineLimit(1)
                    .italic()
                Spacer()
            }
            if let url = recipe.source_url {
                HStack {
                    Button("Learn More") {
                        openURL(url)
                    }
                    Spacer()
                }
            }
        }
    }
    
    @ViewBuilder
    var chevronView: some View {
        if recipe.source_url != nil {
            Image(systemName: "chevron.right")
        }
    }
}

#Preview {
    RecipeView(recipe: Recipe(uuid: "foo", cuisine: "Cuisine", name: "Name"))
}
