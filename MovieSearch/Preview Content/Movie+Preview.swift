//
//  Movie+Preview.swift
//  MovieSearch
//
//  Created by jcontreras on 29/11/24.
//

import Foundation

extension Movie {
    
    static var preview: Movie {
        .init(
            title: "Star Wars: Episode IV - A New Hope",
            year: "1977",
            imdbID: "tt0076759",
            poster: URL(string: "https://m.media-amazon.com/images/M/MV5BOGUwMDk0Y2MtNjBlNi00NmRiLTk2MWYtMGMyMDlhYmI4ZDBjXkEyXkFqcGc@._V1_SX300.jpg")!,
            plot: """
Luke Skywalker joins forces with a Jedi Knight, a cocky pilot, a Wookiee and two droids 
to save the galaxy from the Empire's world-destroying battle station, while also attempting 
to rescue Princess Leia from the mysterious Darth ...
""",
            imdbRating: "8.6"
        )
    }
    
}
