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
    
    // state variables
    
    @State private var animatePageChange = 1
    
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
                    ZStack {
                        // small image (already cached as backround)
                        FullSizeImageView(imageStringURL: mainImage.src.medium)
                        // full size image
                        FullSizeImageView(imageStringURL: mainImage.src.original)
                    }
                    .tag(imagesVM.getImageIndex(for: mainImage))
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
            .animation(.easeInOut(duration: 0.25), value: animatePageChange)
            .padding(.bottom, 32)
            .onChange(of: imagesVM.currentPage) { _, _ in
                animatePageChange = imagesVM.currentPage
            }
        }
        .navigationTitle(Strings.NavigationTitles.imageDetail)
    }
}

#Preview {
    ImageDetailView()
        .environmentObject(ImagesViewModel())
}
