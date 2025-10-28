//
//  ImagesDataModel.swift
//  ImageGalleryApp
//
//  Created by Himanshu's MacBook on 27/10/25.
//

import Foundation

struct ImagesDataModel: Codable {
    let page: Int
    let per_page: Int
    let photos: [ImagesData]
    let total_results: Int
    let next_page: String?
}

struct ImagesData: Codable, Identifiable {
    let id = UUID()
    let width: Int
    let height: Int
    let photographer: String
    let alt: String?
    let src: ImageSouce
}

struct ImageSouce: Codable {
    let original: String
    let large: String
    let medium: String
}
