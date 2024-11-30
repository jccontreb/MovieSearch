//
//  Movie.swift
//  MovieSearch
//
//  Created by jcontreras on 29/11/24.
//

import Foundation

typealias Movies = [Movie]

// MARK: - Movie

struct Movie: Codable, Hashable {
    
    private enum CodingKeys: String, CodingKey {
        case title      = "Title"
        case year       = "Year"
        case imdbID
        case poster     = "Poster"
        case plot       = "Plot"
        case imdbRating
    }
    
    // MARK: - Properties
    
    let title: String
    let year: String
    let imdbID: String
    let poster: URL
    let plot: String?
    let imdbRating: String?
    
}
