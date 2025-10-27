//
//  ImageDetailView.swift
//  ImageGalleryApp
//
//  Created by Himanshu's MacBook on 27/10/25.
//

import SwiftUI

struct ImageDetailView: View {
    
    // MARK: - Properties
    
    // view models
    
    @EnvironmentObject var imagesVM: ImagesViewModel
    
    // MARK: - Body
    
    var body: some View {
        VStack {
            Text(imagesVM.imageDescription)
                .font(.headline)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding([.bottom, .horizontal])
            
            Spacer()
            
            TabView(selection: $imagesVM.currentPage) {
                ForEach(imagesVM.sampleImages, id: \.id) { mainImage in
                    AsyncImage(url: URL(string: mainImage.src.original)) { phase in
                        switch phase {
                        case .empty:
                            ProgressView()
                        case .success(let image):
                            image
                                .detailImageStyle()
                        default:
                            Image(systemName: Strings.Images.placeholderImage)
                                .detailImageStyle()
                        }
                    }
                    .tag(imagesVM.getImageIndex(for: mainImage))
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            
            ScrollView(.horizontal, content: {
                DotIndicatorView(
                    numberOfPages: imagesVM.sampleImages.count,
                    currentPage: imagesVM.currentPage
                )
            })
            .scrollIndicators(.never)
            .padding()
        }
        .navigationTitle(Strings.NavigationTitles.imageDetail)
    }
}

#Preview {
    ImageDetailView()
        .environmentObject(ImagesViewModel())
}
