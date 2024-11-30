//
//  CachedAsyncImage.swift
//  MovieSearch
//
//  Created by jcontreras on 29/11/24.
//

import SwiftUI

// MARK: - CachedAsyncImage

struct CachedAsyncImage<Content>: View where Content: View {
    
    // MARK: - Properties
    
    private let url: URL?
    private let scale: CGFloat
    private let transaction: Transaction
    private let content: (AsyncImagePhase) -> Content
    
    var body: some View {
        if let url, let cachedImage = ImageCache[url] {
            content(.success(cachedImage))
        } else {
            AsyncImage(url: url, scale: scale, transaction: transaction) { phase in
                cacheAndRender(phase: phase)
            }
        }
    }
    
    // MARK: - Lifecycle
    
    init(
        url: URL?,
        scale: CGFloat = 1,
        transaction: Transaction = .init(animation: .easeInOut),
        @ViewBuilder content: @escaping (AsyncImagePhase) -> Content
    ) {
        self.url = url
        self.scale = scale
        self.transaction = transaction
        self.content = content
    }
    
    // MARK: - Methods
    
    private func cacheAndRender(phase: AsyncImagePhase) -> some View {
        if case .success(let image) = phase, let url {
            ImageCache[url] = image
        }
        
        return content(phase)
    }
    
}

// MARK: - ImageCache

fileprivate class ImageCache {
    
    // MARK: - Classes
    
    private class ImageContainer {
        
        // MARK: - Properties
        
        let image: Image
        
        // MARK: - Lifecycle
        
        init(image: Image) {
            self.image = image
        }
        
    }
    
    // MARK: - Properties
    
    static private var cache = NSCache<NSURL, ImageContainer>()
    
    // MARK: - Subscripts
    
    static subscript(url: URL) -> Image? {
        get {
            cache.object(forKey: url as NSURL)?.image
        }
        set {
            guard let newValue else {
                cache.removeObject(forKey: url as NSURL)
                
                return
            }
            
            cache.setObject(.init(image: newValue), forKey: url as NSURL)
        }
    }
    
}
