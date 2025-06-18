//
//  RecipeDetailView.swift
//  Recipies_App
//
//  Created by Mike Nuzzolo on 3/3/25.
//

import SwiftUI

fileprivate extension CGFloat {
    static let imageSize = 400.0
}

struct RecipeDetailView: View {
    @Environment(\.openURL) var openURL

    var viewModel: RecipeViewModel

    var body: some View {
        VStack {
            imageView
            metadataView
            Spacer()
        }
    }
    
    @ViewBuilder
    var imageView: some View {
        CachedAsyncImage(url: viewModel.largeImageURL) { phase in
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
        .frame(maxWidth: .infinity, maxHeight: .imageSize)
        .padding()
    }
    
    @ViewBuilder
    var metadataView: some View {
        VStack {
            Text(viewModel.title)
                .bold()
                .lineLimit(1)
                .font(.title2)
            Text(viewModel.subtitle)
                .lineLimit(1)
                .italic()
            if viewModel.hasMoreInfo, let url = viewModel.moreInfo {
                Button("Learn More") {
                    openURL(url)
                }
                .padding()
            }
        }
    }
}

#Preview {
    RecipeView(viewModel: RecipeViewModel(Recipe(uuid: "foo", cuisine: "Cuisine", name: "Name")))
}
