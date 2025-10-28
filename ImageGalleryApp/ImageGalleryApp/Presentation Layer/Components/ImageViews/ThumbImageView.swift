//
//  ThumbImageView.swift
//  ImageGalleryApp
//
//  Created by Himanshu's MacBook on 29/10/25.
//

import SwiftUI

struct ThumbImageView: View {
    
    let itemWidth: CGFloat
    let imageStringURL: String
    
    var body: some View {
        CacheImage(url: URL(string: imageStringURL)!) { phase in
            switch phase {
            case .success(let image):
                image
                    .gridImageStyle(itemWidth: itemWidth)
            case .failure(_):
                Image(systemName: Strings.Images.placeholderImage)
                    .gridImageStyle(itemWidth: itemWidth)
                    .tint(.gray.opacity(0.7))
            case .empty:
                ProgressView()
            @unknown default:
                Image(systemName: Strings.Images.questionMark)
                    .gridImageStyle(itemWidth: itemWidth)
                    .tint(.gray.opacity(0.7))
            }
        }
    }
}

#Preview {
    ThumbImageView(itemWidth: 100, imageStringURL: "")
}
