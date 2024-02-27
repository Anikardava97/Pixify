//
//  ImageResponse.swift
//  Pixify
//
//  Created by Ani's Mac on 27.02.24.
//

import Foundation

struct ImageResponse: Decodable {
    let total, totalHits: Int
    let hits: [Image]
}
