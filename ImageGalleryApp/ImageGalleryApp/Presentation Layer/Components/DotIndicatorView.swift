//
//  DotIndicatorView.swift
//  ImageGalleryApp
//
//  Created by Himanshu's MacBook on 27/10/25.
//

import SwiftUI

struct DotIndicatorView: View {
    
    // MARK: - Properties
    
    let numberOfPages: Int
    let currentPage: Int
    
    // MARK: - Body
    
    var body: some View {
        HStack(spacing: 8) {
            ForEach(0..<numberOfPages, id: \.self) { index in
                Circle()
                    .fill(
                        index == currentPage
                        ? Color.primary.opacity(0.5)
                        : Color.secondary.opacity(0.25)
                    )
                    .frame(
                        width: index == currentPage ? 8 : 6,
                        height: index == currentPage ? 8 : 6
                    )
                    .animation(.easeInOut(duration: 0.25), value: currentPage)
            }
        }
    }
}

#Preview {
    DotIndicatorView(numberOfPages: 5, currentPage: 2)
}
