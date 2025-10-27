//
//  ImageDetailView.swift
//  ImageGalleryApp
//
//  Created by Himanshu's MacBook on 27/10/25.
//

import SwiftUI

struct ImageDetailView: View {
    
    // MARK: - Properties
    
    let image: String
    
    // MARK: - Body
    
    var body: some View {
        VStack {
            
            Text("Image Details Text Caption")
                .font(.headline)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Image(image)
                .resizable()
                .scaledToFill()
                .frame(maxWidth: .infinity)
                .clipped()
                .cornerRadius(6)
                .padding(54)
                .shadow(
                    color: .black.opacity(0.05),
                    radius: 3,
                    x: 0, y: 3
                )
            
            DotIndicatorView(numberOfPages: 5, currentPage: 2)
        }
        .padding()
        .navigationTitle(Strings.NavigationTitles.imageDetail)
    }
}

#Preview {
    ImageDetailView(image: Strings.Images.defaultImage)
}
