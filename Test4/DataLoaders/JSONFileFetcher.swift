//
//  JSONFileFetcher.swift
//  Test4
//
//  Created by Purusharth Verma on 15/10/22.
//

import Foundation

final class JSONFileFetcher<T: Decodable>: ModelFetcher {
    typealias Model = T
    
    enum JSONFileFetcherError: Error {
        case fileNotFound
        case dataCorrupted
    }
    
    private let fileName: String
    private let modelJSONDataDecoder: ModelJSONDataDecoder
    
    init(fileName: String, modelJSONDataDecoder: ModelJSONDataDecoder) {
        self.fileName = fileName
        self.modelJSONDataDecoder = modelJSONDataDecoder
    }
    
    func fetchModel(withCompletionHandler completionHandler: @escaping (Result<Model, Error>) -> Void) {
        guard let pathURL = Bundle.main.url(forResource: fileName, withExtension: "json") else {
            completionHandler(.failure(JSONFileFetcherError.fileNotFound))
            return
        }
        guard let data = try? Data(contentsOf: pathURL) else {
            completionHandler(.failure(JSONFileFetcherError.dataCorrupted))
            return
        }
        
        do {
            let model: T = try modelJSONDataDecoder.decode(data)
            completionHandler(.success(model))
        } catch {
            completionHandler(.failure(error))
        }
    }
}
