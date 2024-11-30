//
//  MovieSearchResult.swift
//  MovieSearch
//
//  Created by jcontreras on 29/11/24.
//

import Foundation

// MARK: - MovieSearchResult

struct MovieSearchResult: Decodable {
    
    // MARK: - CodingKeys
    
    private enum CodingKeys: String, CodingKey {
        case movies = "Search"
    }
    
    // MARK: - Properties
    
    let movies: Movies
    
}
