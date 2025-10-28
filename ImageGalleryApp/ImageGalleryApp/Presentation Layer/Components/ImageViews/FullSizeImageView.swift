//
//  FullSizeImageView.swift
//  ImageGalleryApp
//
//  Created by Himanshu's MacBook on 29/10/25.
//

import SwiftUI

struct FullSizeImageView: View {
    
    let imageStringURL: String
    
    var body: some View {
        CacheImage(url: URL(string: imageStringURL)!) { phase in
            switch phase {
            case .success(let image):
                image
                    .detailImageStyle()
            case .failure(_):
                Image(systemName: Strings.Images.placeholderImage)
                    .tint(.gray.opacity(0.7))
            case .empty:
                ProgressView()
            @unknown default:
                Image(systemName: Strings.Images.questionMark)
                    .tint(.gray.opacity(0.7))
            }
        }
    }
}

#Preview {
    FullSizeImageView(imageStringURL: "")
}
