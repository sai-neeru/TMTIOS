//
//  FeedProvider.swift
//  RedditDemo
//
//  Created by Sai Pavan Neerukonda on 4/1/21.
//

import Foundation

protocol Networking {
  func execute<T: Decodable>(_ requestProvider: RequestProviding, completion: @escaping (Result<T, Error>) -> Void)
}

class BaseNetworking: Networking {
    func execute<T: Decodable>(_ requestProvider: RequestProviding, completion: @escaping (Result<T, Error>) -> Void) {
        let urlRequest = requestProvider.urlRequest
        
        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            do {
                if let error = error {
                    completion(.failure(error))
                    return
                }
                
                guard let data = data else {
                    preconditionFailure("No error was received but we also don't have data...")
                }
                
                let decodedObject = try JSONDecoder().decode(T.self, from: data)
                
                completion(.success(decodedObject))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}

class MockNetworking: Networking {
    var error: Error?
    
    func execute<T: Decodable>(_ requestProvider: RequestProviding, completion: @escaping (Result<T, Error>) -> Void) {
        if let error = error {
            return completion(.failure(error))
        }
        guard let data = try? stubData(name: requestProvider.mockPath) else { completion(.failure(NSError(domain: "Unable to read json", code: 0, userInfo: nil)))
            return
        }
        guard let response = try? JSONDecoder().decode(T.self, from: data) else {
            completion(.failure(NSError(domain: "Unable to parse json", code: 0, userInfo: nil)))
            return
        }
        completion(.success(response))
    }
    
    func stubData(name: String) throws -> Data? {
        let bundle = Bundle(for: type(of: self))
        guard let fileUrl = bundle.url(forResource: name, withExtension: "json") else {
            return nil
        }
        let data = try? Data(contentsOf: fileUrl)
        return data
    }
}
