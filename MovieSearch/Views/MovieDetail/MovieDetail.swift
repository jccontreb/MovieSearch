//
//  MovieDetail.swift
//  MovieSearch
//
//  Created by jcontreras on 29/11/24.
//

import SwiftUI

// MARK: - MovieDetail

struct MovieDetail: View {
    
    // MARK: - Properties
    
    @Environment(\.dismiss) private var dismiss
    
    @AppStorage("favorites") private var favoritesData: Data?
    
    @State private var model = MovieDetailViewModel()
    
    let movie: Movie
    
    private var favoriteMovies: Movies? {
        favoritesData?.asMovies
    }
    
    private var isFavorite: Bool {
        favoriteMovies?.contains { $0 == model.movieDetails } ?? false
    }
    
    var body: some View {
        contentView
            .navigationTitle(movie.title)
            .navigationBarTitleDisplayMode(.inline)
            .onAppear { model.fetchDetails(for: movie) }
            .toolbar {
                Button(action: toggleFavorite) {
                    Image(systemName: isFavorite ? "heart.fill" : "heart")
                        .foregroundStyle(isFavorite ? .red : .secondary)
                }
                .disabled(model.movieDetails == nil)
            }
    }
    
    @ViewBuilder
    private var contentView: some View {
        if model.isLoading {
            ProgressView()
        } else if let movieDetails = model.movieDetails {
            ScrollView {
                LazyVStack(alignment: .leading, spacing: 16) {
                    Text(movieDetails.title)
                        .font(.largeTitle)
                    
                    if let plot = movieDetails.plot?.trim(), !plot.isEmpty {
                        Text(plot)
                    }
                    
                    if let rating = movieDetails.imdbRating?.trim(), !rating.isEmpty {
                        LabeledContent("IMDB rating:", value: rating)
                            .font(.footnote)
                    }
                    
                    CachedAsyncImage(url: movieDetails.poster) { phase in
                        switch phase {
                        case .empty:
                            ProgressView()
                        case .success(let image):
                            image
                                .resizable()
                                .scaledToFit()
                                .clipShape(RoundedRectangle(cornerRadius: 8))
                        case .failure:
                            EmptyView()
                        @unknown default:
                            let _ = assertionFailure("Unsupported phase: \(phase)")
                            EmptyView()
                        }
                    }
                    .shadow(radius: 8)
                }
                .padding()
            }
        } else {
            ContentUnavailableView {
                Image(systemName: "exclamationmark.triangle")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 60, height: 60)
                    .foregroundStyle(.secondary)
                    .padding()
            } description: {
                Text("Could not retreive the movie details.")
                    .font(.title2)
                    .foregroundStyle(Color(.label))
                    .bold()
            } actions: {
                Button("Dismiss") { dismiss() }
                    .buttonStyle(.borderedProminent)
            }
        }
    }
    
    // MARK: - Methods
    
    private func toggleFavorite() {
        guard let movie = model.movieDetails else { return }
        
        if isFavorite {
            favoritesData = favoriteMovies?.filter { $0.imdbID != movie.imdbID }.asData
        } else {
            var favoriteMovies = self.favoriteMovies ?? .init()
            
            favoriteMovies.append(movie)
            
            favoritesData = favoriteMovies.asData
        }
    }
    
}

#Preview {
    NavigationStack {
        MovieDetail(movie: .preview)
    }
}
