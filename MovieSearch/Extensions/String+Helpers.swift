//
//  String+Helpers.swift
//  MovieSearch
//
//  Created by jcontreras on 29/11/24.
//

import Foundation

extension String {
    
    func trim(characterSet: CharacterSet = .whitespacesAndNewlines) -> String {
        return trimmingCharacters(in: characterSet)
    }
    
}
