//
//  ImageGalleryView.swift
//  ImageGalleryApp
//
//  Created by Himanshu's MacBook on 27/10/25.
//

import SwiftUI

struct ImageGalleryView: View {
    
    // MARK: - Properties
    
    let items = Array(1...30)
    
    let columnsCount = 5
    let spacing: CGFloat = 8
    
    var defaultImage: String {
        Strings.Images.defaultImage
    }
    
    // MARK: - Body
    
    var body: some View {
        NavigationStack {
            GeometryReader { geometry in
                let totalSpacing = spacing * CGFloat(columnsCount - 1)
                let itemWidth = (geometry.size.width - totalSpacing) / CGFloat(columnsCount)
                
                ScrollView {
                    LazyVGrid(
                        columns: Array(
                            repeating: GridItem(.flexible(), spacing: spacing),
                            count: columnsCount
                        ),
                        spacing: spacing
                    ) {
                        ForEach(items, id: \.self) { name in
                            NavigationLink {
                                ImageDetailView(image: defaultImage)
                            } label: {
                                Image(defaultImage)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(
                                        width: itemWidth,
                                        height: itemWidth
                                    )
                                    .clipped()
                                    .cornerRadius(6)
                            }

                        }
                    }
                    .padding(spacing)
                }
            }
            .navigationTitle(Strings.NavigationTitles.imageGallery)
        }
    }
}

#Preview {
    ImageGalleryView()
}
