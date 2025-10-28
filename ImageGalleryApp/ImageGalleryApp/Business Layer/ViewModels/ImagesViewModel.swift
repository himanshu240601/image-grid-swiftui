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
    @Published var hasMoreData = true
    @Published var isLoadingMore = false
    
    // computed properties
    
    var imageDescription: String {
        let image = sampleImages[currentPage]
        return image.alt ?? "Photo by \(image.photographer)"
    }
    
    var loadMoreImages: Bool {
        return hasMoreData && (isLoadingMore == false)
    }
    
    // private values
    
    private var currentPageIndex: Int = 1
    private var imagesFetchLimit: Int = 20
    
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
    
    /// Method to check if image is last in array
    /// - Parameter image: image to set index for, in images array
    /// - Returns: return bool for true or false
    func checkLastImage(for image: ImagesData) -> Bool {
        return image.id == sampleImages.last?.id
    }
    
    // MARK: - API Methdos
    
    @MainActor
    func fetchPhotos(refresh: Bool = false) async {
        guard loadMoreImages else { return }
        isLoadingMore = true
        defer { isLoadingMore = false }
        
        if refresh {
            // reset pagination
            currentPageIndex = 1
            // remove all data from images list
            sampleImages.removeAll()
        }
        
        // create url
        var url = URLs.getCompleteURL(for: .curated)
        // append query
        url += "?page=\(currentPageIndex)&per_page=\(imagesFetchLimit)"
        print("URL: \(url)")
        // set header for autorization with token key
        let headers = [
            Strings.Keys.authorization: URLs.getPexelsAuthroizationKey()
        ]

        do {
            let photos: ImagesDataModel = try await NetworkManager.shared.request(
                url: url,
                method: RequestTypes.GET.rawValue,
                headers: headers
            )
            
            if photos.photos.count < imagesFetchLimit {
                hasMoreData = false
            }
            DispatchQueue.main.async {
                self.currentPageIndex += 1
                self.sampleImages += photos.photos
            }
        } catch {
            print(#function, error.localizedDescription)
        }
    }
}
