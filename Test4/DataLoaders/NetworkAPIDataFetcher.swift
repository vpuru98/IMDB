//
//  NetworkAPIDataFetcher.swift
//  Test4
//
//  Created by Purusharth Verma on 15/10/22.
//

import Foundation

protocol NetworkAPIDataFetcher {
    func fetchData(forRequest request: URLRequest,
                   withCompletionHandler completionHandler: @escaping (Result<Data, Error>) -> Void)
}

final class NetworkAPIDataFetcherImp: NetworkAPIDataFetcher {
    enum NetworkAPIDataFetcherImpError: Error {
        case dataNotFound
        case apiError
    }
    
    private let urlSession: URLSession
    
    init(urlSession: URLSession) {
        self.urlSession = urlSession
    }
    
    func fetchData(forRequest request: URLRequest,
                   withCompletionHandler completionHandler: @escaping (Result<Data, Error>) -> Void) {
        
        urlSession.dataTask(with: request) { data, response, error in
            if let error = error {
                completionHandler(.failure(error))
                return
            }
            guard let data = data else {
                completionHandler(.failure(NetworkAPIDataFetcherImpError.dataNotFound))
                return
            }
            guard let httpResponse = response as? HTTPURLResponse,
                  (200..<300).contains(httpResponse.statusCode) else {
                // More exhanustive error code handling based on status code can be done
                completionHandler(.failure(NetworkAPIDataFetcherImpError.apiError))
                return
            }
            completionHandler(.success(data))
        }.resume()
    }
    
}
