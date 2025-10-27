//
//  Endpoints.swift
//  ImageGalleryApp
//
//  Created by Himanshu's MacBook on 28/10/25.
//

import Foundation

struct URLs {
    
    // MARK: - Base URL
    
    static let base = "https://api.pexels.com/v1/"
    
    // MARK: - Endpoints
    
    enum EndPoints: String {
        case curated
    }
    
    // MARK: - Methods
    
    static func getCompleteURL(for endPoint: EndPoints) -> String {
        return base + endPoint.rawValue
    }
    
    static func getPexelsAuthroizationKey() -> String {
        if let apiKey = Bundle.main.object(forInfoDictionaryKey: Strings.Keys.pexelsString) as? String {
            return apiKey
        }
        return ""
    }
}
