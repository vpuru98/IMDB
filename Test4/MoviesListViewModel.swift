//
//  MoviesListViewModel.swift
//  Test4
//
//  Created by Purusharth Verma on 15/10/22.
//

import Foundation



protocol MoviesListViewModel {
    var numberOfMovies: Int { get }
    func updateMoviesList(withCompletionHandler completionHandler: @escaping (Bool) -> Void)
    func getMovieAtIndex(_ index: Int) -> Movie?
}

final class MoviesListViewModelImp: MoviesListViewModel {
    private let dataLoader: MoviesDataLoader
    private var moviesList: [Movie] = []
    
    var numberOfMovies: Int {
        moviesList.count
    }
    
    init(dataLoader: MoviesDataLoader) {
        self.dataLoader = dataLoader
    }
    
    func updateMoviesList(withCompletionHandler completionHandler: @escaping (Bool) -> Void) {
        dataLoader.fetchMovies { [weak self] result in
            self?.handleMoviesResult(result, withCompletionHandler: completionHandler)
        }
    }
    
    func getMovieAtIndex(_ index: Int) -> Movie? {
        guard index >= 0 && index < moviesList.count else { return nil }
        return moviesList[index]
    }
    
    private func handleMoviesResult(_ result: Result<[Movie], Error>,
                                    withCompletionHandler completionHandler: @escaping (Bool) -> Void) {
        
        // Proper try catch block can be used an exact errors can be handled
        guard let moviesList = try? result.get() else {
            completionHandler(false)
            return
        }
        
        self.moviesList = moviesList
        completionHandler(true)
    }
    
}
