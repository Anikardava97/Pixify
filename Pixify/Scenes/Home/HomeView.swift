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
        NavigationStack {
            verticalScrollView
            loadMoreButton
        }
        .navigationBarBackButtonHidden()
    }
    
    //MARK: - Images Grid
    private var verticalScrollView: some View {
        ScrollView {
            imageGrid
        }
    }
    
    private var imageGrid: some View {
        LazyVGrid(columns: columns, spacing: spacing) {
            ForEach(viewModel.images) { image in
                NavigationLink(value: image) {
                    ImagesGridView(image: image)
                }
            }
        }
        .padding(.horizontal, 16)
        .navigationDestination(for: Image.self) { selectedImage in
            DetailsView(viewModel: DetailsViewModel(image: selectedImage))
        }
    }
    
    //MARK: - Load More Button
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
