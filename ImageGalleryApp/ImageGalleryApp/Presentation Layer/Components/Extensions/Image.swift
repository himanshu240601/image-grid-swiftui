//
//  Image.swift
//  ImageGalleryApp
//
//  Created by Himanshu's MacBook on 28/10/25.
//

import SwiftUI

extension Image {
    func detailImageStyle() -> some View {
        self
            .resizable()
            .scaledToFit()
            .cornerRadius(6)
            .shadow(
                color: .black.opacity(0.05),
                radius: 3,
                x: 0, y: 3
            )
            .padding(.horizontal)
    }
    
    func gridImageStyle(itemWidth: CGFloat) -> some View {
        self
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
