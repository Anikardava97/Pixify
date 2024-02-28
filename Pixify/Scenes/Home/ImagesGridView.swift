//
//  ImagesGridView.swift
//  Pixify
//
//  Created by Ani's Mac on 28.02.24.
//

import SwiftUI

struct ImagesGridView: View {
    // MARK: - Properties
    let image: Image
    
    // MARK: - Body
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            imageThumbnail
            imageAuthor
        }
        .frame(height: 240, alignment: .leading)
        .cornerRadius(12)
        .shadow(radius: 3)
    }
    
    // MARK: - Content
    private var imageThumbnail: some View {
        AsyncImage(url: URL(string: image.largeImageURL ?? "")) { imageThumbnail in
            imageThumbnail.resizable()
                .scaledToFill()
                .frame(width: 170, height: 200)
                .cornerRadius(12)
                .clipped()
        } placeholder: {
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.customSecondaryColor.opacity(0.2))
                .frame(width: 170, height: 200)
        }
    }
    
    private var imageAuthor: some View {
        Text("@ \(image.user)")
            .font(.system(size: 14, weight: .medium))
            .foregroundStyle(Color.customTextColor.opacity(0.6))
            .lineLimit(1)
    }
}

