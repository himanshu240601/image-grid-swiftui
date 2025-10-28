//
//  ErrorView.swift
//  ImageGalleryApp
//
//  Created by Himanshu's MacBook on 29/10/25.
//

import SwiftUI

struct ErrorView: View {
    let error: String
    
    var body: some View {
        VStack(spacing: 8) {
            Spacer()
            Image(systemName: "exclamationmark.triangle.fill")
                .resizable()
                .frame(width: 34, height: 34)
            Text(error)
                .font(.headline)
                .frame(maxWidth: .infinity)
            Spacer()
        }
        .foregroundStyle(.gray)
    }
}

#Preview {
    ErrorView(error: "error")
}
