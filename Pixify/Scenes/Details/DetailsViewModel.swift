//
//  DetailsViewModel.swift
//  Pixify
//
//  Created by Ani's Mac on 27.02.24.
//

import Foundation

final class DetailsViewModel {
    // MARK: - Properties
    var image: Image?
    
    // MARK: - Computed Properties
    var mainImage: String {
        image?.largeImageURL ?? ""
    }
    
    var imageSize: Int {
        image?.imageSize ?? 0
    }
    
    var imageType: String {
        image?.type ?? ""
    }
    
    var imageTag: String {
        image?.tags ?? ""
    }
    
    var imageAuthorUsername: String {
        image?.user ?? ""
    }
    
    var imageViewsCount: Int {
        image?.views ?? 0
    }
    
    var imageLikesCount: Int {
        image?.likes ?? 0
    }
    
    var imageCommentsCount: Int {
        image?.comments ?? 0
    }
    
    var imageCollectionsCount: Int {
        image?.collections ?? 0
    }
    
    var imageDownloadsCount: Int {
        image?.downloads ?? 0
    }
    
    // MARK: - Init
    init(image: Image) {
        self.image = image
    }
}
