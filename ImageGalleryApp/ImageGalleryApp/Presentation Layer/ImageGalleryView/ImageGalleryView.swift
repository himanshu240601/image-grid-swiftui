//
//  ImageGalleryView.swift
//  ImageGalleryApp
//
//  Created by Himanshu's MacBook on 27/10/25.
//

import SwiftUI

struct ImageGalleryView: View {
    
    // MARK: - Properties
    
    // view models
    
    @StateObject private var imagesVM = ImagesViewModel()
    
    // ui state values
    
    let columnsCount = 5
    let spacing: CGFloat = 8
    
    // MARK: - Body
    
    var body: some View {
        NavigationStack {
            GeometryReader { geometry in
                // calculate total spacing between grids in columns
                let totalSpacing = spacing * CGFloat(columnsCount - 1)
                // calculate the size of image grid
                let itemWidth = (geometry.size.width - totalSpacing) / CGFloat(columnsCount)
                
                if imagesVM.sampleImages.isEmpty && !imagesVM.errorFetchingImages.isEmpty {
                    ErrorView(error: imagesVM.errorFetchingImages)
                } else if imagesVM.sampleImages.isEmpty {
                    LoaderView()
                } else {
                    ScrollView {
                        LazyVGrid(
                            columns: Array(
                                repeating: GridItem(.flexible(), spacing: spacing),
                                count: columnsCount
                            ),
                            spacing: spacing
                        ) {
                            ForEach(imagesVM.sampleImages, id: \.id) { image in
                                NavigationLink {
                                    ImageDetailView()
                                        .environmentObject(imagesVM)
                                        .onAppear {
                                            imagesVM.setImageIndex(for: image)
                                        }
                                } label: {
                                    ThumbImageView(itemWidth: itemWidth, imageStringURL: image.src.medium)
                                }
                                .onAppear {
                                    if imagesVM.checkLastImage(for: image) && imagesVM.loadMoreImages {
                                        Task {
                                            await imagesVM.fetchPhotos()
                                        }
                                    }
                                }
                            }
                        }
                        .padding(spacing)
                    }
                }
            }
            .navigationTitle(Strings.NavigationTitles.imageGallery)
        }
    }
}

#Preview {
    ImageGalleryView()
}
