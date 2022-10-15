//
//  MovieViewModel.swift
//  Test4
//
//  Created by Purusharth Verma on 15/10/22.
//

import Foundation

protocol MovieListItemViewModel {
    var imageURL: String { get }
    var title: String { get }
    var description: String { get }
}

extension Movie: MovieListItemViewModel {
    var imageURL: String {
        return posterPath
    }
    
    var title: String {
        return originalTitle
    }
    
    var description: String {
        return overview
    }
}
