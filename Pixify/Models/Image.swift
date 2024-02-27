//
//  Image.swift
//  Pixify
//
//  Created by Ani's Mac on 26.02.24.
//

import Foundation

struct ImageResponse: Codable {
    let images: [Image]
}

struct Image: Codable {
    let id: Int
    let type: TypeEnum
    let tags: String
    let largeImageURL: String
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

enum TypeEnum: String, Codable {
    case illustration = "illustration"
    case photo = "photo"
}
