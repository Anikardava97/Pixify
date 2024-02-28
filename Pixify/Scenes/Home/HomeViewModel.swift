//
//  HomeViewModel.swift
//  Pixify
//
//  Created by Ani's Mac on 26.02.24.
//

import Foundation

final class HomeViewModel: ObservableObject {
    // MARK: - Properties
    @Published private(set) var images: [Image] = []
    @Published private var error: String?
    @Published private var imagesURL = ApiManager.baseUrl + ApiManager.apiKey
    
    @Published var currentPage = 1
    @Published private var isFetchingImages = false
    @Published private var hasMoreImages = true
    
    @Published var selectedImage: Image?
    @Published var isDetailsViewPresented = false
    
    // MARK: - Init
    init() {
        fetchImages()
    }
    
    private func fetchImages() {
        NetworkManager.shared.fetch(from: imagesURL) { [weak self] (result: Result<ImageResponse, NetworkError>) in
            switch result {
            case .success(let fetchedImages):
                self?.images = fetchedImages.hits
            case .failure(let error):
                self?.error = error.localizedDescription
            }
        }
    }
    
    // MARK: - Methods
    func fetchImages(searchQuery: String? = nil, isNewSearch: Bool = false) {
        guard !isFetchingImages, hasMoreImages else { return }
        
        if isNewSearch {
            images = []
            currentPage = 1
            hasMoreImages = true
        }
        
        isFetchingImages = true
        
        var url = imagesURL + "&page=\(currentPage)&per_page=20"
        if let query = searchQuery, !query.isEmpty {
            url = ApiManager.baseUrl + ApiManager.apiKey + ApiManager.searchParameters(for: query) + "&page=\(currentPage)&per_page=20"
        }
        
        NetworkManager.shared.fetch(from: url) { [weak self] (result: Result<ImageResponse, NetworkError>) in
            self?.isFetchingImages = false
            switch result {
            case .success(let fetchedImages):
                if self?.images == nil {
                    self?.images = []
                }
                self?.images.append(contentsOf: fetchedImages.hits)
                self?.hasMoreImages = !fetchedImages.hits.isEmpty
                self?.currentPage += 1
            case .failure(let error):
                self?.error = error.localizedDescription
            }
        }
    }
}

