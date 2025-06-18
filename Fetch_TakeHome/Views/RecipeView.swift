//
//  RecipeView.swift
//  Recipies_App
//
//  Created by Mike Nuzzolo on 3/3/25.
//

import SwiftUI

extension CGFloat {
    static let imageSize = 64.0
}

struct RecipeView: View {
    @Environment(\.openURL) var openURL

    @ObservedObject var viewModel: RecipeViewModel

    var body: some View {
        HStack {
            imageView
            metadataView
            chevronView
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
                Spacer()
            }
            HStack {
                Text(viewModel.subtitle)
                    .lineLimit(1)
                    .italic()
                Spacer()
            }
            if viewModel.hasMoreInfo, let url = viewModel.moreInfo {
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
        if viewModel.hasMoreInfo {
            Image(systemName: "chevron.right")
        }
    }
}

#Preview {
    RecipeView(viewModel: RecipeViewModel(Recipe(uuid: "foo", cuisine: "Cuisine", name: "Name")))
}
