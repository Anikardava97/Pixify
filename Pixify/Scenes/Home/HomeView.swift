//
//  HomeView.swift
//  Pixify
//
//  Created by Ani's Mac on 27.02.24.
//

import SwiftUI

struct HomeView: View {
    // MARK: - Properties
    @StateObject var viewModel = HomeViewModel()
    private let spacing: CGFloat = 16
    private var columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    // MARK: - Body
    var body: some View {
        content
    }
    
    //MARK: - Content
    private var content: some View {
        NavigationView {
            VStack {
                headerView
                verticalScrollView
                loadMoreButton
            }
        }
        .navigationBarBackButtonHidden()
        .sheet(isPresented: $viewModel.isDetailsViewPresented) {
            if let selectedImage = viewModel.selectedImage {
                VStack() {
                    Spacer().frame(height: 24)
                    DetailsView(viewModel: DetailsViewModel(image: selectedImage))
                }
            }
        }
    }
    
    private var headerView: some View {
        Text("Discover Inspiring Photos")
            .font(.system(size: 20, weight: .bold))
            .foregroundStyle(Color.customTextColor.opacity(0.6))
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 20)
    }
    
    private var verticalScrollView: some View {
        ScrollView {
            imageGrid
        }
    }
    
    private var imageGrid: some View {
        LazyVGrid(columns: columns, spacing: spacing) {
            ForEach(viewModel.images) { image in
                Button(action: {
                    viewModel.selectedImage = image
                    viewModel.isDetailsViewPresented = true
                }) {
                    ImagesGridView(image: image)
                }
            }
        }
        .padding(.horizontal, 16)
    }
    
    private var loadMoreButton: some View {
        Button {
            //
        } label: {
            Text("Load More")
                .foregroundStyle(Color.customAccentColor)
                .fontWeight(.medium)
        }
    }
}

#Preview {
    HomeView()
}
