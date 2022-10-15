//
//  ImageFetcher.swift
//  Test4
//
//  Created by Purusharth Verma on 15/10/22.
//

import Foundation
import UIKit

protocol ImageFetcher {
    func fetchImage(forURLString urlString: String,
                    withCompletionHandler completionHandler: @escaping (Result<UIImage, Error>) -> Void)
}

final class ImageFetcherImp: ImageFetcher {
    private typealias Handler = (Result<UIImage, Error>) -> Void
    enum ImageFetcherImpError: Error {
        case malformedURL
        case corruptedData
    }
    
    private let cache = NSCache<NSString, UIImage>()
    private var pendingHandlers: [String: [Handler]] = [:]
    private let networkAPIDataFetcher: NetworkAPIDataFetcher
    
    init(networkAPIDataFetcher: NetworkAPIDataFetcher) {
        self.networkAPIDataFetcher = networkAPIDataFetcher
    }
    
    func fetchImage(forURLString urlString: String,
                    withCompletionHandler completionHandler: @escaping (Result<UIImage, Error>) -> Void) {
        
        guard let url = URL(string: urlString) else {
            completionHandler(.failure(ImageFetcherImpError.malformedURL))
            return
        }
        
        let str = urlString as NSString
        if let image = cache.object(forKey: str) {
            completionHandler(.success(image))
            return
        }
        
        pendingHandlers[urlString]?.append(completionHandler)
        guard pendingHandlers.count == 1 else {
            return
        }
        
        let request = URLRequest(url: url)
        networkAPIDataFetcher.fetchData(forRequest: request) { [weak self] result in
            guard let weakSelf = self else { return }
            switch result {
            case.failure(let error):
                completionHandler(.failure(error))
            case .success(let data):
                guard let image = UIImage(data: data) else { return }
                weakSelf.cache.setObject(image, forKey: str)
                weakSelf.pendingHandlers[urlString]?.forEach({ $0(.success(image)) })
            }
        }
    }
}

