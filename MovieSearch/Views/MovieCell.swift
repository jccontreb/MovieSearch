//
//  MovieCell.swift
//  MovieSearch
//
//  Created by jcontreras on 29/11/24.
//

import SwiftUI

// MARK: - MovieCell

struct MovieCell: View {
    
    // MARK: - Properties
    
    @State private var size = CGSize.zero
    
    let movie: Movie
    
    var body: some View {
        HStack {
            CachedAsyncImage(url: movie.poster) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFit()
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                case .failure:
                    defaultImage
                @unknown default:
                    let _ = assertionFailure("Unsupported phase: \(phase)")
                    defaultImage
                }
            }
            .frame(height: size.height)
            .frame(maxWidth: 80)
            .shadow(radius: 8)
            
            VStack(alignment: .leading) {
                Text(movie.title)
                    .font(.headline)
                
                Text(movie.year)
                    .font(.subheadline)
            }
            .padding(.vertical)
            .saveSize(in: $size)
        }
    }
    
    private var defaultImage: some View {
        Image(systemName: "movieclapper")
            .resizable()
            .scaledToFit()
            .frame(maxWidth: 60)
    }
    
}

#Preview {
    MovieCell(movie: .preview)
}
