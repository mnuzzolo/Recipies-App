//
//  RecipieView.swift
//  Fetch_TakeHome
//
//  Created by Mike Nuzzolo on 3/3/25.
//

import SwiftUI

extension CGFloat {
    static let imageSize = 64.0
}

struct RecipieView: View {
    @Environment(\.openURL) var openURL
    
    let recipie: Recipie

    var body: some View {
        HStack {
            imageView
            metadataView
            chevronView
        }
    }
    
    @ViewBuilder
    var imageView: some View {
        AsyncImage(url: recipie.photo_url_small) { phase in
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
                Text(recipie.name)
                    .bold()
                    .lineLimit(1)
                Spacer()
            }
            HStack {
                Text(recipie.cuisine)
                    .lineLimit(1)
                    .italic()
                Spacer()
            }
            if let url = recipie.source_url {
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
        if recipie.source_url != nil {
            Image(systemName: "chevron.right")
        }
    }
}

#Preview {
    RecipieView(recipie: Recipie(uuid: "foo", cuisine: "Cuisine", name: "Name"))
}
