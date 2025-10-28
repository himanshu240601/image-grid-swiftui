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
                
                if imagesVM.sampleImages.isEmpty {
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
                                    CacheImage(url: URL(string: image.src.medium)!) { phase in
                                        switch phase {
                                        case .success(let image):
                                            image
                                                .gridImageStyle(itemWidth: itemWidth)
                                        case .failure(_):
                                            Image(systemName: Strings.Images.placeholderImage)
                                                .resizable()
                                                .scaledToFit()
                                                .frame(
                                                    width: itemWidth,
                                                    height: itemWidth
                                                )
                                                .clipped()
                                                .cornerRadius(6)
                                                .tint(.gray.opacity(0.7))
                                        case .empty:
                                            ProgressView()
                                        @unknown default:
                                            Image(systemName: Strings.Images.questionMark)
                                        }
                                    }
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
            .refreshable {
                Task {
                    await imagesVM.fetchPhotos(refresh: true)
                }
            }
        }
    }
}

#Preview {
    ImageGalleryView()
}
