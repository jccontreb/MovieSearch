//
//  OMDBAPI.swift
//  MovieSearch
//
//  Created by jcontreras on 29/11/24.
//

import Combine
import Foundation

// MARK: - OMDBAPI

class OMDBAPI {
    
    // MARK: - Properties
    
    private static let urlString = "www.omdbapi.com"
    private static let apiKey = "80eea7c"
    
    private static var session: URLSession { .shared }
    
    // MARK: - Methods
    
    private static func urlBuilder(queryItems: [URLQueryItem] = .init()) -> URL? {
        var urlComponents = URLComponents()
        
        urlComponents.scheme = "https"
        urlComponents.host = urlString
        
        urlComponents.queryItems = [
            .init(name: "apikey", value: apiKey),
            .init(name: "r", value: "json")
        ]
        
        if !queryItems.isEmpty {
            urlComponents.queryItems?.append(contentsOf: queryItems)
        }
        
        return urlComponents.url
    }
    
    private static func verifyStatusCode(from response: URLResponse) throws {
        guard let httpResponse = response as? HTTPURLResponse else {
            throw OMDBAPIError.invalidRespose
        }
        
        let statusCode = httpResponse.statusCode
        
        guard (200 ..< 300).contains(statusCode) else {
            throw OMDBAPIError.unexpectedStatusCode(statusCode)
        }
    }
    
    static func searchMoviesBy(title: String) -> AnyPublisher<Movies, Error> {
        guard let url = urlBuilder(queryItems: [.init(name: "s", value: title)]) else {
            return Fail(error: OMDBAPIError.badURL)
                .eraseToAnyPublisher()
        }
        
        return session
            .dataTaskPublisher(for: url)
            .tryMap { data, response in
                try verifyStatusCode(from: response)
                
                let decoder = JSONDecoder()
                
                return try decoder.decode(MovieSearchResult.self, from: data).movies
            }
            .mapError { OMDBAPIError.from(error: $0) }
            .eraseToAnyPublisher()
    }
    
    static func fetchDetails(for movie: Movie) -> AnyPublisher<Movie, Error> {
        guard let url = urlBuilder(queryItems: [.init(name: "i", value: movie.imdbID)]) else {
            return Fail(error: OMDBAPIError.badURL)
                .eraseToAnyPublisher()
        }
        
        return session
            .dataTaskPublisher(for: url)
            .tryMap { data, response in
                try verifyStatusCode(from: response)
                
                let decoder = JSONDecoder()
                
                return try decoder.decode(Movie.self, from: data)
            }
            .mapError { OMDBAPIError.from(error: $0) }
            .eraseToAnyPublisher()
    }
    
}

// MARK: - OMDBAPIError

enum OMDBAPIError {
    
    // MARK: - Cases
    
    case badURL
    case notConnectedToInternet
    case networkConnectionLost
    case invalidRespose
    case unexpectedStatusCode(Int)
    case decodingFailed
    case other(Error)
    
    // MARK: - Methods
    
    fileprivate static func from(error: Error) -> OMDBAPIError {
        if let apiError = error as? OMDBAPIError {
            return apiError
        }
        
        if let urlError = error as? URLError {
            let apiError: OMDBAPIError
            
            switch urlError.code {
            case .badURL: apiError = .badURL
            case .notConnectedToInternet: apiError = .notConnectedToInternet
            case .networkConnectionLost: apiError = .networkConnectionLost
            default: apiError = .other(error)
            }
            
            return apiError
        }
        
        if error as? DecodingError != nil {
            return .decodingFailed
        }
        
        return .other(error)
    }
    
}

// MARK: - OMDBAPIError + LocalizedError

extension OMDBAPIError: LocalizedError {
    
    var errorDescription: String? {
        switch self {
        case .badURL: 
            return "The request could not be made"
        case .notConnectedToInternet: 
            return "Not connected to the internet"
        case .networkConnectionLost: 
            return "Network connection lost"
        case .invalidRespose: 
            return "The response from the server is incorrect"
        case .unexpectedStatusCode: 
            return "An unexpected status code was received from the server"
        case .decodingFailed: 
            return "Corrupted data recevied from the server"
        case .other: 
            return "An unexpected error occurred"
        }
    }
    
}
