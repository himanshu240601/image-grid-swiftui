//
//  ImagesViewModel.swift
//  ImageGalleryApp
//
//  Created by Himanshu's MacBook on 27/10/25.
//

import SwiftUI

final class ImagesViewModel: ObservableObject {
    
    // MARK: - Properties
    
    // data
    
    @Published var sampleImages: [ImagesData] = []
    
    // published variables
    
    @Published var currentPage: Int = 0
    
    // computed properties
    
    var imageDescription: String {
        let image = sampleImages[currentPage]
        return image.alt ?? "Photo by \(image.photographer)"
    }
    
    // MARK: - Initializer
    
    init() {
        Task {
            await fetchPhotos()
        }
    }
    
    // MARK: - Methods
    
    /// Method to get index of current selected image
    /// - Parameter image: image to get index for, in images array
    /// - Returns: index of the image
    func getImageIndex(for image: ImagesData) -> Int {
        let index = sampleImages.firstIndex { $0.id == image.id } ?? 0
        print("\(#function) \(index)")
        return index
    }
    
    /// Method to set index of current selected image
    /// - Parameter image: image to set index for, in images array
    func setImageIndex(for image: ImagesData) {
        let index = sampleImages.firstIndex { $0.id == image.id } ?? 0
        DispatchQueue.main.async {
            self.currentPage = index
        }
        print("\(#function) \(index)")
    }
    
    // MARK: - API Methdos
    
    @MainActor
    func fetchPhotos() async {
        var url = URLs.getCompleteURL(for: .curated)
        url += "?per_page=40"
        let headers = [
            Strings.Keys.authorization: URLs.getPexelsAuthroizationKey()
        ]

        do {
            let photos: ImagesDataModel = try await NetworkManager.shared.request(
                url: url,
                method: RequestTypes.GET.rawValue,
                headers: headers
            )
            DispatchQueue.main.async {
                self.sampleImages = photos.photos
            }
        } catch {
            print(#function, error.localizedDescription)
        }
    }
}
