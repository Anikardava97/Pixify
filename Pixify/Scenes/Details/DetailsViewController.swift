//
//  DetailsViewController.swift
//  Pixify
//
//  Created by Ani's Mac on 27.02.24.
//

import UIKit

final class DetailsViewController: UIViewController {
    // MARK: - Methods
    private var viewModel: DetailsViewModel?
    
    private let mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var imageInfoStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [imageView, tagsLabel, typeLabel, sizeLabel, authorNameLabel])
        stackView.axis = .vertical
        stackView.spacing = 12
        return stackView
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 12
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let tagsLabel: UILabel = {
        let label = UILabel()
        label.textColor = .customTextColor
        label.font = UIFont.italicSystemFont(ofSize: 16)
        label.numberOfLines = 0
        return label
    }()
    
    private let typeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .customTextColor
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    private let sizeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .customTextColor
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    private let authorNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .customTextColor
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    private let imageViewsAndDownloadsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 8
        stackView.distribution = .fill
        return stackView
    }()
    
    private let imageLikesCommentsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 8
        stackView.distribution = .fill
        return stackView
    }()
    
    let viewsDetailView = IconLabelView()
    let downloadsDetailView = IconLabelView()
    let savesDetailView = IconLabelView()
    let likesDetailView = IconLabelView()
    let commentsDetailView = IconLabelView()
    
    // MARK: - ViewLifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    // MARK: - Private Methods
    private func setup() {
        setupBackground()
        setupSubviews()
        setupConstraints()
    }
  
    private func setupBackground() {
        view.backgroundColor = .customBackgroundColor
    }

    private func setupSubviews() {
        view.addSubview(mainStackView)
        mainStackView.addArrangedSubview(imageInfoStackView)
        mainStackView.addArrangedSubview(imageViewsAndDownloadsStackView)
        mainStackView.addArrangedSubview(imageLikesCommentsStackView)
        
        imageViewsAndDownloadsStackView.addArrangedSubview(viewsDetailView)
        imageViewsAndDownloadsStackView.addArrangedSubview(downloadsDetailView)
        imageViewsAndDownloadsStackView.addArrangedSubview(savesDetailView)
        imageViewsAndDownloadsStackView.addArrangedSubview(UIView())
        
        imageLikesCommentsStackView.addArrangedSubview(likesDetailView)
        imageLikesCommentsStackView.addArrangedSubview(commentsDetailView)
        imageLikesCommentsStackView.addArrangedSubview(UIView())
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            mainStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            mainStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            imageView.heightAnchor.constraint(equalToConstant: 400)
        ])
    }
    
    private func setImage(from url: String) {
        NetworkManager.shared.downloadImage(from: url) { [weak self] image in
            DispatchQueue.main.async {
                self?.imageView.image = image
            }
        }
    }
    
    // MARK: - Configure
    func configure(with image: Image) {
        viewModel = DetailsViewModel(image: image)
        if let imageUrl = image.largeImageURL {
            setImage(from: imageUrl)
        }   
        tagsLabel.text = "# \(viewModel?.imageTag ?? "")"
        typeLabel.text = "Image Type: \(viewModel?.imageType ?? "")"
        sizeLabel.text = "Image Size: \(viewModel?.imageSize ?? 0)"
        authorNameLabel.text = "Image Author: @\(viewModel?.imageAuthorUsername ?? "")"
        
        viewsDetailView.configure(icon: UIImage(systemName: "eye.fill"), text: "\(viewModel?.imageViewsCount ?? 0)")
        downloadsDetailView.configure(icon: UIImage(systemName: "arrow.down.circle.fill"), text: "\(viewModel?.imageDownloadsCount ?? 0)")
        savesDetailView.configure(icon: UIImage(systemName: "bookmark.fill"), text: "\(viewModel?.imageCollectionsCount ?? 0)")
        likesDetailView.configure(icon: UIImage(systemName: "heart.fill"), text: "\(viewModel?.imageLikesCount ?? 0)")
        commentsDetailView.configure(icon: UIImage(systemName: "message.fill"), text: "\(viewModel?.imageCommentsCount ?? 0)")
    }
}
