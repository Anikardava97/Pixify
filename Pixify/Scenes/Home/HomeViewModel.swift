//
//  HomeViewModel.swift
//  Pixify
//
//  Created by Ani's Mac on 26.02.24.
//

protocol HomeViewModelDelegate: AnyObject {
    func fetchedImages(_ images: [Image])
    func showError(_ receivedError: Error)
    func navigateToImageDetails(with image: Image)
}

final class HomeViewModel {
    // MARK: - Properties
    private var images: [Image]?
    private var currentPage = 1
    private var isFetchingImages = false
    private var hasMoreImages = true
    weak var delegate: HomeViewModelDelegate?
    
    // MARK: - Methods
    func viewDidLoad() {
        fetchImages()
    }
    
    func fetchImages(searchQuery: String? = nil, isNewSearch: Bool = false) {
        guard !isFetchingImages, hasMoreImages else { return }
        
        if isNewSearch {
            images = []
            currentPage = 1
            hasMoreImages = true
        }
        
        isFetchingImages = true
        
        let searchParameters = ApiManager.searchParameters(for: searchQuery) + "&page=\(currentPage)&per_page=20"
        let imagesURL = ApiManager.baseUrl + ApiManager.apiKey + searchParameters
        
        NetworkManager.shared.fetch(from: imagesURL) { [weak self] (result: Result<ImageResponse, NetworkError>) in
            self?.isFetchingImages = false
            switch result {
            case .success(let fetchedImages):
                if self?.images == nil {
                    self?.images = []
                }
                self?.images?.append(contentsOf: fetchedImages.hits)
                self?.delegate?.fetchedImages(self?.images ?? [])
                self?.hasMoreImages = !fetchedImages.hits.isEmpty
                self?.currentPage += 1
            case .failure(let error):
                self?.delegate?.showError(error)
            }
        }
    }
    
    func loadMoreImages(searchQuery: String? = nil) {
        fetchImages(searchQuery: searchQuery)
    }
    
    func navigateToRestaurantDetails(with image: Image) {
        delegate?.navigateToImageDetails(with: image)
    }
}
