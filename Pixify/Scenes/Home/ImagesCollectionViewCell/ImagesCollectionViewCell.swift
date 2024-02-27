//
//  ImagesCollectionViewCell.swift
//  Pixify
//
//  Created by Ani's Mac on 27.02.24.
//

import UIKit

final class ImagesCollectionViewCell: UICollectionViewCell {
    // MARK: - Properties
    private var image: Image?
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let authorNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .customTextColor.withAlphaComponent(0.6)
        label.numberOfLines = 1
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview()
        setupConstraints()
        setupCellAppearance()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: - CellLifeCycle
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
        authorNameLabel.text = nil
    }
    
    // MARK: - Private Methods
    private func addSubview() {
        contentView.addSubview(imageView)
        contentView.addSubview(authorNameLabel)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 200),
            
            authorNameLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 12),
            authorNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8)
        ])
    }
    
    private func setupCellAppearance() {
        layer.borderColor = UIColor.gray.withAlphaComponent(0.1).cgColor
        layer.borderWidth = 1.0
        layer.cornerRadius = 12
        
        contentView.layer.cornerRadius = layer.cornerRadius
        contentView.layer.masksToBounds = true
        
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 4)
        layer.shadowRadius = 6.0
        layer.shadowOpacity = 0.1
        layer.masksToBounds = false
    }
    
    private func setImage(from url: String) {
        let currentURL = self.image?.largeImageURL
        NetworkManager.shared.downloadImage(from: url) { [weak self] image in
            DispatchQueue.main.async {
                if self?.image?.largeImageURL == currentURL {
                    self?.imageView.image = image
                }
            }
        }
    }
    
    // MARK: - Configuration
    func configure(with image: Image) {
        self.image = image
        authorNameLabel.text = "@ \(image.user)"
        
        if let imageURL = image.largeImageURL {
            setImage(from: imageURL)
        }
    }
}

