//
//  ModelFetcher.swift
//  Test4
//
//  Created by Purusharth Verma on 15/10/22.
//

import Foundation

protocol ModelFetcher {
    associatedtype Model: Decodable
    func fetchModel(withCompletionHandler
                     completionHandler: @escaping (Result<Model, Error>) -> Void)
}
