//
//  RecipeView.swift
//  Recipes_App
//
//  Created by Mike Nuzzolo on 3/3/25.
//

import SwiftUI

fileprivate extension CGFloat {
    static let imageSize = 64.0
}

struct RecipeView: View {
    @Environment(\.openURL) var openURL

    var viewModel: RecipeViewModel

    var body: some View {
        HStack {
            imageView
            metadataView
        }
    }
    
    @ViewBuilder
    var imageView: some View {
        CachedAsyncImage(url: viewModel.smallImageURL) { phase in
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
                Text(viewModel.title)
                    .bold()
                    .lineLimit(1)
                    .foregroundColor(.accent)
                Spacer()
            }
            HStack {
                Text(viewModel.subtitle)
                    .lineLimit(1)
                    .italic()
                Spacer()
            }
        }
    }
}

#Preview {
    RecipeView(viewModel: RecipeViewModel(Recipe(uuid: "foo", cuisine: "Cuisine", name: "Name")))
}
