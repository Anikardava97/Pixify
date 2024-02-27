//
//  ApiManager.swift
//  Pixify
//
//  Created by Ani's Mac on 26.02.24.
//

import Foundation

struct ApiManager {
    static let baseUrl = "https://pixabay.com/api/?key="
    static let apiKey = "42585935-49ef4973398606c4a226ccd58"
    
    static func searchParameters(for query: String? = nil) -> String {
        let baseParameters = "&image_type=photo&pretty=true"
        guard let query, !query.isEmpty else { return baseParameters }
        return "&q=\(query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")\(baseParameters)"
    }
}
