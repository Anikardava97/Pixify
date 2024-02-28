//
//  DetailsView.swift
//  Pixify
//
//  Created by Ani's Mac on 28.02.24.
//

import SwiftUI

struct DetailsView: View {
    // MARK: - Properties
    @ObservedObject var viewModel: DetailsViewModel

    // MARK: - Body
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            imageThumbnail
            imageInfoView
        }
    }
    
    // MARK: - Content
    private var imageThumbnail: some View {
        AsyncImage(url: URL(string: viewModel.mainImage)) { imageThumbnail in
            imageThumbnail.resizable()
                .scaledToFill()
                .frame(height: 400)
                .cornerRadius(12)
                .clipped()
        } placeholder: {
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.customSecondaryColor.opacity(0.2))
                .frame(width: 170, height: 200)
        }
        .padding(.horizontal, 20)
    }
    
    private var imageInfoView: some View {
        VStack(alignment: .leading, spacing: 12) {
            imageTagsView
            imageTypeView
            imageSizeView
            imageAuthorNameView
        }
        .padding(.horizontal, 20)
    }
    
    private var imageTagsView: some View {
        Text("# \(viewModel.imageTag)")
            .italic()
            .font(.system(size: 16))
            .foregroundStyle(Color.customTextColor)
    }
    
    private var imageTypeView: some View {
        Text(viewModel.imageType)
            .font(.system(size: 16))
            .foregroundStyle(Color.customTextColor)
    }
    
    private var imageSizeView: some View {
        Text("\(viewModel.imageSize)")
            .font(.system(size: 16))
            .foregroundStyle(Color.customTextColor)
    }
    
    private var imageAuthorNameView: some View {
        Text(viewModel.imageTag)
            .font(.system(size: 16))
            .foregroundStyle(Color.customTextColor)
    }
}



