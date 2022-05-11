//
//  RestAPIClient.swift
//  Country
//
//  Created by a.diliprao.chavan on 10/05/22.
//

import Foundation
import Combine

protocol RestAPIClientProtocol {
    func get<T: Decodable>(request: Provider, decode: T.Type) -> AnyPublisher<T, Error>
}

class RestAPIClient: RestAPIClientProtocol{
    

    /// API request with method GET
    ///
    /// - Parameter url: request url
    /// - Parameter parameter: body parameters
    /// - Parameter decode : decode type
    
    func get<T: Decodable>(request: Provider, decode: T.Type) -> AnyPublisher<T, Error> {
        dump("Request: \(request.url)")
        guard let url = URL(string: request.url) else {
            return Fail<T, Error>(error: APIError.invalidURL).eraseToAnyPublisher()
        }
        return URLSession.shared
             .dataTaskPublisher(for: url)
             .requestJSON(httpCodes: .success)
    }
}


typealias HTTPCode = Int
typealias HTTPCodes = Range<HTTPCode>
extension HTTPCodes {
    static let success = 200 ..< 300
}


private extension Publisher where Output == URLSession.DataTaskPublisher.Output {
    func requestJSON<Value>(httpCodes: HTTPCodes) -> AnyPublisher<Value, Error> where Value: Decodable {
        return tryMap {
                assert(!Thread.isMainThread)
                guard let code = ($0.1 as? HTTPURLResponse)?.statusCode else {
                    throw APIError.unexpectedResponse
                }
                guard httpCodes.contains(code) else {
                    throw APIError.httpCode(code)
                }
                return $0.0
            }
            .extractUnderlyingError()
            .decode(type: Value.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}


extension Publisher {
    func extractUnderlyingError() -> Publishers.MapError<Self, Failure> {
        mapError {
            ($0.underlyingError as? Failure) ?? $0
        }
    }
}


private extension Error {
    var underlyingError: Error? {
        let nsError = self as NSError
        if nsError.domain == NSURLErrorDomain && nsError.code == -1009 {
            // "The Internet connection appears to be offline."
            return self
        }
        return nsError.userInfo[NSUnderlyingErrorKey] as? Error
    }
}
