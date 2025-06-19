//
//  RecipeDetailView.swift
//  Recipes_App
//
//  Created by Mike Nuzzolo on 3/3/25.
//

import SwiftUI

fileprivate extension CGFloat {
    static let imageSize = 300.0
}

struct RecipeDetailView: View {
    @Environment(\.openURL) var openURL

    var viewModel: RecipeViewModel

    var body: some View {
        ScrollView {
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
                    .frame(width: 100, height: 100)
            case .success(let image):
                image.resizable()
                    .aspectRatio(contentMode: .fit)
            default:
                Image(systemName: "photo")
                    .resizable()
            }
        }
        .frame(maxWidth: .infinity, idealHeight: .imageSize)
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
            Text(viewModel.details)
                .padding()
            if viewModel.hasMoreInfo, let url = viewModel.moreInfo {
                Button("Learn More") {
                    openURL(url)
                }
                .padding()
            }
        }
        .padding(.horizontal)
    }
}

#Preview {
    RecipeView(viewModel: RecipeViewModel(Recipe(uuid: "foo", cuisine: "Cuisine", name: "Name")))
}
