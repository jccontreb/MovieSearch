//
//  FavoritesList.swift
//  MovieSearch
//
//  Created by jcontreras on 29/11/24.
//

import SwiftUI

// MARK: - FavoritesList

struct FavoritesList: View {
    
    // MARK: - Properties
    
    @AppStorage("favorites") private var favoritesData: Data?
    
    private var favorites: Movies { favoritesData?.asMovies ?? .init() }
    
    var body: some View {
        NavigationStack {
            contentView
                .navigationTitle("Favorites")
        }
    }
    
    @ViewBuilder
    private var contentView: some View {
        if favorites.isEmpty {
            ContentUnavailableView("You have not registered any movies as favorite so far.",
                systemImage: "movieclapper",
                description: Text("Search for movies and mark them as favorite for them to appear in this list.")
            )
        } else {
            List {
                ForEach(favorites, id: \.self) { movie in
                    NavigationLink {
                        MovieDetail(movie: movie)
                    } label: {
                        MovieCell(movie: movie)
                    }
                }
                .onDelete(perform: deleteFavorites)
            }
            .toolbar { EditButton() }
        }
    }
    
    // MARK: - Methods
    
    private func deleteFavorites(at indexSet: IndexSet) {
        let moviesToDelete = indexSet.map { favorites[$0] }
        let updatedFavorites = favorites.filter { !moviesToDelete.contains($0) }
        
        favoritesData = updatedFavorites.asData
    }
    
}

#Preview {
    FavoritesList()
}
