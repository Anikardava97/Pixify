//
//  HomeViewController.swift
//  Pixify
//
//  Created by Ani's Mac on 26.02.24.
//

import UIKit

final class HomeViewController: UIViewController {
    // MARK: - Methods
    private let viewModel = HomeViewModel()
    private var images = [Image]()
    private var searchController = UISearchController(searchResultsController: nil)
    
    private let mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let headerLabel: UILabel = {
        let label = UILabel()
        label.text = "Discover Inspiring Photos"
        label.textColor = .customTextColor.withAlphaComponent(0.6)
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        return label
    }()
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 16
        layout.minimumLineSpacing = 16
        layout.sectionInset = UIEdgeInsets(top: 16, left: 0, bottom: 16, right: 0)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.showsVerticalScrollIndicator = false
        return collectionView
    }()
    
    // MARK: - ViewLifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        hideBackButton()
        setup()
        viewModel.viewDidLoad()
    }
    
    // MARK: - Private Methods
    private func hideBackButton() {
        navigationItem.setHidesBackButton(true, animated: false)
    }
    
    private func setup() {
        setupViewModelDelegate()
        setupBackground()
        setupSearchController()
        setupCollectionView()
        setupSubviews()
        setupConstraints()
    }
    
    private func setupViewModelDelegate() {
        viewModel.delegate = self
    }
    
    private func setupBackground() {
        view.backgroundColor = .customBackgroundColor
    }
    
    private func setupSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Photos"
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    private func setupCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(ImagesCollectionViewCell.self, forCellWithReuseIdentifier: "imageCell")
    }
    
    private func setupSubviews() {
        view.addSubview(mainStackView)
        mainStackView.addArrangedSubview(headerLabel)
        mainStackView.addArrangedSubview(collectionView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            mainStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            mainStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            mainStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

// MARK: - Extension: UISearchResultsUpdating
extension HomeViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text else { return }
        viewModel.fetchImages(searchQuery: searchText)
    }
}

// MARK: - Extension: UICollectionViewDataSource
extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "imageCell", for: indexPath) as? ImagesCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        let image = images[indexPath.row]
        cell.configure(with: image)
        return cell
    }
}

// MARK:  Extension: UICollectionViewDelegate
extension HomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedImage = images[indexPath.row]
        viewModel.navigateToRestaurantDetails(with: selectedImage)
    }
}

// MARK:  Extension: UICollectionViewDelegateFlowLayout
extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
        
        let totalSpace = flowLayout.sectionInset.left
        + flowLayout.sectionInset.right
        + flowLayout.minimumInteritemSpacing
        
        let width = Int((collectionView.bounds.width - totalSpace) / 2)
        let height = 240
        
        return CGSize(width: width, height: height)
    }
}

// MARK: - Extension: HomeViewModelDelegate
extension HomeViewController: HomeViewModelDelegate {
    func fetchedImages(_ images: [Image]) {
        self.images = images
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
    func showError(_ receivedError: Error) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "Error", message: receivedError.localizedDescription, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            self.present(alert, animated: true)
        }
    }
    
    func navigateToImageDetails(with image: Image) {
        let imageDetailsViewController = DetailsViewController()
        imageDetailsViewController.configure(with: image)
        navigationController?.pushViewController(imageDetailsViewController, animated: true)
    }
}


