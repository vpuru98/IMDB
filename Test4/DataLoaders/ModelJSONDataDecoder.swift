//
//  ModelJSONDataDecoder.swift
//  Test4
//
//  Created by Purusharth Verma on 15/10/22.
//

import Foundation

final class ModelJSONDataDecoder {
    enum ModelJSONDataDecoderError: Error {
        case decodingError
    }
    
    private let jsonDecoder: JSONDecoder
    
    init(jsonDecoder: JSONDecoder) {
        self.jsonDecoder = jsonDecoder
    }
    
    func decode<T: Decodable>(_ data: Data) throws -> T {
        guard let model = try? jsonDecoder.decode(T.self, from: data) else {
            throw ModelJSONDataDecoderError.decodingError
        }
        return model
    }
}
