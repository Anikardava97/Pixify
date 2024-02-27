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
    weak var delegate: HomeViewModelDelegate?
    
    // MARK: - Methods
    func viewDidLoad() {
        fetchImages()
    }
    
    func fetchImages(searchQuery: String? = nil) {
        let searchParameters = ApiManager.searchParameters(for: searchQuery)
        let imagesURL = ApiManager.baseUrl + ApiManager.apiKey + searchParameters
        
        NetworkManager.shared.fetch(from: imagesURL) { [weak self] (result: Result<ImageResponse, NetworkError>) in
            switch result {
            case .success(let fetchedImages):
                self?.images = fetchedImages.hits
                self?.delegate?.fetchedImages(fetchedImages.hits)
            case .failure(let error):
                self?.delegate?.showError(error)
            }
        }
    }
    
    func navigateToRestaurantDetails(with image: Image) {
        delegate?.navigateToImageDetails(with: image)
    }
}
