//
//  MovieListViewModel.swift
//  MovieSearch
//
//  Created by jcontreras on 29/11/24.
//

import Combine
import Foundation
import Observation

// MARK: - MovieListViewModel

@Observable
class MovieListViewModel {
    
    // MARK: - Properties
    
    @ObservationIgnored
    private lazy var subscribers = Set<AnyCancellable>()
    
    private(set) var movies: Movies?
    private(set) var isLoading = false
    private(set) var error: OMDBAPIError? {
        didSet { displayError = error != nil }
    }
    
    var searchTitle = ""
    var displayError = false {
        didSet {
            guard !displayError else { return }
            
            error = nil
        }
    }
    
    // MARK: - Intents
    
    func fetchMovies() {
        let trimmedTitleFilter = searchTitle.trim()
        
        guard !trimmedTitleFilter.isEmpty else { return }
        
        isLoading = true
        
        OMDBAPI
            .searchMoviesBy(title: trimmedTitleFilter)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] result in
                if case .failure(let error) = result {
                    self?.error = error as? OMDBAPIError
                }
                
                self?.isLoading = false
            } receiveValue: { [weak self] movies in
                self?.movies = movies
            }
            .store(in: &subscribers)
    }
    
}
