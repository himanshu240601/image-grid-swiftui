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
                    CacheImage(url: URL(string: mainImage.src.original)!) { phase in
                        switch phase {
                        case .success(let image):
                            image
                                .detailImageStyle()
                        case .failure(_):
                            Image(systemName: Strings.Images.placeholderImage)
                                .resizable()
                                .scaledToFit()
                                .cornerRadius(6)
                                .shadow(
                                    color: .black.opacity(0.05),
                                    radius: 3,
                                    x: 0, y: 3
                                )
                                .padding(.horizontal)
                                .tint(.gray.opacity(0.7))
                        case .empty:
                            ProgressView()
                        @unknown default:
                            Image(systemName: Strings.Images.questionMark)
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
