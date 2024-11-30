//
//  MovieDetailViewModel.swift
//  MovieSearch
//
//  Created by jcontreras on 29/11/24.
//

import Combine
import Foundation
import Observation

// MARK: - MovieDetailViewModel

@Observable
class MovieDetailViewModel {
    
    // MARK: - Properties
    
    @ObservationIgnored
    private lazy var subscribers = Set<AnyCancellable>()
    
    private(set) var movieDetails: Movie?
    private(set) var isLoading = false
    
    // MARK: - Intents
    
    func fetchDetails(for movie: Movie) {
        isLoading = true
        
        OMDBAPI
            .fetchDetails(for: movie)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.isLoading = false
            } receiveValue: { [weak self] movie in
                self?.movieDetails = movie
            }
            .store(in: &subscribers)
    }
    
}
