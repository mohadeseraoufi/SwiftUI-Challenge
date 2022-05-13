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

final class MockClient: CovidClient {
    
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
    
    func fetchData<T>(from endpoint: APIEndpoint, _ completion: @escaping (Result<T, APIError>) -> Void) where T : Decodable, T : Encodable {
        
        guard let response = endpoints[endpoint] else {
            completion(.failure(.requestFailed))
            return
        }

        switch response {
            case .success(let url):
                self.response(for: url) { (info: T) in
                    completion(.success(info))
                }
            case .failure(let error):
                completion(.failure(error))
        }
    }

    func fetchCovidInfo(_ completion: @escaping (Result<[CovidInfoModel], APIError>) -> Void) {
        
        fetchData(from: .covidInfo, completion)
        
    }
    
    
    func fetchCovidDetailInfo(with url: String, _ completion: @escaping (Result<CountryCovidDetailModel, APIError>) -> Void) {
        
        fetchData(from: .countryDetail(url), completion)
    }
    
    func refreshInfo(_ completion: @escaping (Result<[CovidInfoModel], APIError>) -> Void) {
        
        fetchData(from: .covidInfo, completion)
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
