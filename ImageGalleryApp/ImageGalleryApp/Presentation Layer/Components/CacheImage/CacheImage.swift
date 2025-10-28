//
//  CacheImage.swift
//  ImageGalleryApp
//
//  Created by Himanshu's MacBook on 28/10/25.
//

import SwiftUI

struct CacheImage<Content>: View where Content: View {
    
    // MARK: - Properties
    
    private let url: URL
    private let scale: CGFloat
    private let transaction: Transaction
    private let content: (AsyncImagePhase) -> Content

    // MARK: - Initializer
    
    init(
        url: URL,
        scale: CGFloat = 1.0,
        transaction: Transaction = Transaction(),
        @ViewBuilder content: @escaping (AsyncImagePhase) -> Content
    ) {
        self.url = url
        self.scale = scale
        self.transaction = transaction
        self.content = content
    }

    // MARK: - Body
    
    var body: some View {
        if let cached = ImageCache[url] {
            content(.success(cached))
        } else {
            AsyncImage(
                url: url,
                scale: scale,
                transaction: transaction
            ) { phase in
                cacheAndRender(phase: phase)
            }
        }
    }

    // MARK: - Methods
    
    func cacheAndRender(phase: AsyncImagePhase) -> some View {
        if case .success(let image) = phase {
            ImageCache[url] = image
        }
        return content(phase)
    }
}

#Preview {
    CacheImage(
        url: URL(string: "https://camo.githubusercontent.com/3cae61090608")!
    ) { phase in
        switch phase {
        case .empty:
            ProgressView()
        case .success(let image):
            image
        case .failure(_):
            Text("**Error**")
                .font(.system(size: 60))
        @unknown default:
            fatalError()
        }
    }
}

fileprivate class ImageCache {
    static private var cache: [URL: Image] = [:]

    static subscript(url: URL) -> Image? {
        get {
            ImageCache.cache[url]
        }
        set {
            ImageCache.cache[url] = newValue
        }
    }
}
