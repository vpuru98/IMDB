//
//  Movie.swift
//  Test4
//
//  Created by Purusharth Verma on 15/10/22.
//

import Foundation

// TODO: Use this model instead of [Model]. Realized at last moment :(
struct MoviesResponse: Decodable {
    let results: [Movie]
}

struct Movie: Decodable {
    let originalTitle: String
    let overview: String
    let posterPath: String
    let releaseDate: String
    let popularity: String
    
    enum CodingKeys: String, CodingKey {
        case originalTitle = "original_title"
        case overview
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case popularity
    }
}
