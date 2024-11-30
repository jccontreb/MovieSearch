//
//  MovieList.swift
//  MovieSearch
//
//  Created by jcontreras on 29/11/24.
//

import SwiftUI

// MARK: - MovieList

struct MovieList: View {
    
    // MARK: - Properties
    
    @State private var model = MovieListViewModel()
    
    var body: some View {
        NavigationStack {
            VStack {
                searchView
                
                contentView
            }
            .navigationTitle("Movies")
            .animation(.easeIn, value: model.isLoading)
            .alert(isPresented: $model.displayError, error: model.error) { error in
                Button("Dismiss") { model.displayError = false }
            } message: { error in
                Text(error.failureReason ?? "")
            }
        }
    }
    
    private var searchView: some View {
        HStack {
            TextField("Search for a movie", text: $model.searchTitle)
                .textFieldStyle(.roundedBorder)
                .onAppear { UITextField.appearance().clearButtonMode = .whileEditing }
                .onSubmit { model.fetchMovies() }
            
            Button("Search") { model.fetchMovies() }
                .buttonStyle(.borderedProminent)
                .disabled(model.searchTitle.trim().isEmpty || model.isLoading)
        }
        .padding([.top, .horizontal])
    }
    
    @ViewBuilder
    private var contentView: some View {
        if let movies = model.movies, !movies.isEmpty {
            List {
                ForEach(movies, id: \.self) { movie in
                    NavigationLink {
                        MovieDetail(movie: movie)
                    } label: {
                        MovieCell(movie: movie)
                    }
                }
            }
            .listStyle(.plain)
        } else {
            ContentUnavailableView("No movies found",
                systemImage: "movieclapper",
                description: Text("Start by searching for a movie or modify your search.")
            )
        }
    }
    
}

#Preview {
    MovieList()
}
