//
//  URLSession+Extension.swift
//  PokeChallenge01
//
//  Created by Tanaka Soushi on 2022/11/04.
//

import Foundation

enum PokeAPIError: Error {
    case notFoundJson
    case statusError
}

extension URLSession {
    func dataTask(with url: URL, handler: @escaping (Data?, URLResponse?, Error?) -> Void) {
        guard let url = Bundle.main.url(forResource: "pokeData", withExtension: "json") else {
            handler(nil, nil, PokeAPIError.notFoundJson)
            return
        }
        let statusCode = [200, 200, 200, 200, 404].randomElement() ?? 200
        let response = HTTPURLResponse(url: url, statusCode: statusCode, httpVersion: nil, headerFields: nil)
        let error = statusCode == 404 ? PokeAPIError.statusError : nil
        let data = (error != nil) ? nil : try? Data(contentsOf: url)
        handler(data, response, error)
    }
}
