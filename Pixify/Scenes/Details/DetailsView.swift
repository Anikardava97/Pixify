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
                imageInfoFirstSectionStack
                imageInfoSecondSectionStack
                Spacer()
            }
            .padding(.horizontal, 20)
    }
    
    // MARK: - Content
    private var imageThumbnail: some View {
        AsyncImage(url: URL(string: viewModel.mainImage)) { imageThumbnail in
            imageThumbnail.resizable()
                .scaledToFill()
                .frame(width: UIScreen.main.bounds.width - 40, height: 400)
                .cornerRadius(12)
                .clipped()
        } placeholder: {
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.customSecondaryColor.opacity(0.2))
                .frame(height: 400)
        }
    }
    
    private var imageInfoFirstSectionStack: some View {
        VStack(alignment: .leading, spacing: 8) {
            imageTagsView
            imageTypeView
            imageSizeView
            imageAuthorNameView
        }
    }
    
    private var imageTagsView: some View {
        Text("# \(viewModel.imageTag)")
            .italic()
            .font(.system(size: 16))
            .foregroundStyle(Color.customTextColor)
    }
    
    private var imageTypeView: some View {
        Text("Image Type: \(viewModel.imageType)")
            .font(.system(size: 16))
            .foregroundStyle(Color.customTextColor)
    }
    
    private var imageSizeView: some View {
        Text("Image Size: \(viewModel.imageSize)")
            .font(.system(size: 16))
            .foregroundStyle(Color.customTextColor)
    }
    
    private var imageAuthorNameView: some View {
        Text("Image Author: @\(viewModel.imageAuthorUsername)")
            .font(.system(size: 16))
            .foregroundStyle(Color.customTextColor)
    }
    
    private var imageInfoSecondSectionStack: some View {
        VStack(alignment: .leading, spacing: 8) {
            imageViewsAndDownloadsStack
            imageLikesAndCommentsStack
        }
    }
    
    private var imageViewsAndDownloadsStack: some View {
        HStack(spacing: 8) {
            IconAndLabelView(iconName: "eye.fill", text: "\(viewModel.imageViewsCount)")
            IconAndLabelView(iconName: "arrow.down.circle.fill", text: "\(viewModel.imageDownloadsCount)")
            IconAndLabelView(iconName: "bookmark.fill", text: "\(viewModel.imageCollectionsCount)")
        }
    }
    
    private var imageLikesAndCommentsStack: some View {
        HStack(spacing: 8) {
            IconAndLabelView(iconName: "heart.fill", text: "\(viewModel.imageLikesCount)")
            IconAndLabelView(iconName: "message.fill", text: "\(viewModel.imageCommentsCount)")
        }
    }
}



