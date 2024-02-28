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
}

