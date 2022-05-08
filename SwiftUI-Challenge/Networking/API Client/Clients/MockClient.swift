//
//  MockClient.swift
//  Cocoacasts
//
//  Created by Bart Jacobs on 20/01/2020.
//  Copyright © 2020 Code Foundry. All rights reserved.
//

/**
 The `MockClient` class can be used to locally
 test the Cocoacasts application without
 the need for a local server.
 */

import Foundation

final class MockClient: APIClient {
    
    // MARK: - Types

   enum Response {

        // MARK: - Cases

        case success(URL)
        case failure(APIError)

    }

    // MARK: - Properties

    private var endpoints: [APIEndpoint: Response] = {
        var endPoints: [APIEndpoint: Response] = [:]
        APIEndpoint.allCases.forEach { endPoint in
            endPoints[endPoint] = .failure(.requestNotFound)
        }
        return endPoints
    }()

    
    // MARK: - API Client

    func fetchCovidInfo(_ completion: @escaping (Result<[CovidInfoModel], APIError>) -> Void) {
        guard let response = endpoints[.covidInfo] else {
            completion(.failure(.requestFailed))
            return
        }

        switch response {
            case .success(let url):
                self.response(for: url) { (episodes: [CovidInfoModel]) in
                    completion(.success(episodes))
                }
            case .failure(let error):
                completion(.failure(error))
        }
    }
    
    
    func fetchCovidDetailInfo(with url: String, _ completion: @escaping (Result<CountryCovidDetailModel, APIError>) -> Void) {
        
        guard let response = endpoints[.countryDetail(url)] else {
            completion(.failure(.requestFailed))
            return
        }

        switch response {
            case .success(let url):
                self.response(for: url) { (covidDetailInfo: CountryCovidDetailModel) in
                    completion(.success(covidDetailInfo))
                }
            case .failure(let error):
                completion(.failure(error))
        }
    }
    
    func refreshInfo(_ completion: @escaping (Result<[CovidInfoModel], APIError>) -> Void) {
        guard let response = endpoints[.covidInfo] else {
            completion(.failure(.requestFailed))
            return
        }

        switch response {
            case .success(let url):
                self.response(for: url) { (episodes: [CovidInfoModel]) in
                    completion(.success(episodes))
                }
            case .failure(let error):
                completion(.failure(error))
        }
    }
    
    private func response<T: Decodable>(for url: URL, completion: @escaping (T) -> Void) {
        DispatchQueue.global(qos: .utility).async {
            guard let data = try? Data(contentsOf: url) else {
                fatalError("Unable to Load Mock Data")
            }
            
            // Initialize JSON Decoder
            let decoder = JSONDecoder()
            
            // Configure JSON Decoder
            decoder.dateDecodingStrategy = .iso8601
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            
            // Decode JSON Response
            guard let result = try? decoder.decode(T.self, from: data) else {
                fatalError("Unable to Decode Mock Data")
            }
            
            completion(result)
        }
    }
    
    func setResponse(_ response:Response, for endpoint: APIEndpoint) {
        endpoints[endpoint] = response
    }
    
}
