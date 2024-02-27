//
//  Image.swift
//  Pixify
//
//  Created by Ani's Mac on 26.02.24.
//

import Foundation

struct Image: Decodable {
    let id: Int
    let type: String
    let tags: String
    let largeImageURL: String?
    let imageSize: Int
    let views, downloads, collections, likes, comments: Int
    let userID: Int
    let user: String
    let userImageURL: String
    
    enum CodingKeys: String, CodingKey {
        case id, type, tags, largeImageURL, imageSize, views, downloads, collections, likes, comments
        case userID = "user_id"
        case user, userImageURL
    }
}

