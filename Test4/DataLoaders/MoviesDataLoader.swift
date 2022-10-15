//
//  MoviesDataLoader.swift
//  Test4
//
//  Created by Purusharth Verma on 15/10/22.
//

import Foundation

protocol MoviesDataLoader {
    func fetchMovies(withCompletionHandler
                     completionHandler: @escaping (Result<[Movie], Error>) -> Void)
}

final class MoviesJSONDataLoaderImp: MoviesDataLoader {
    private let modelFetcher: JSONFileFetcher<[Movie]>
    
    init(modelFetcher: JSONFileFetcher<[Movie]>) {
        self.modelFetcher = modelFetcher
    }
    
    func fetchMovies(withCompletionHandler completionHandler: @escaping (Result<[Movie], Error>) -> Void) {
        modelFetcher.fetchModel(withCompletionHandler: completionHandler)
    }
}





