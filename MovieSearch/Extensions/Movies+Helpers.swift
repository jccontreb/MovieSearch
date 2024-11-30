//
//  Movies+Helpers.swift
//  MovieSearch
//
//  Created by jcontreras on 29/11/24.
//

import Foundation

extension Movies {
    
    var asData: Data? {
        guard !self.isEmpty else { return nil }
        
        return try? JSONEncoder().encode(self)
    }
    
}

extension Data {
    
    var asMovies: Movies? {
        try? JSONDecoder().decode(Movies.self, from: self)
    }
    
}
