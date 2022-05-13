//
//  APIClient.swift
//  Cocoacasts
//
//  Created by Bart Jacobs on 06/11/2019.
//  Copyright © 2019 Code Foundry. All rights reserved.
//

import Foundation
//import CocoaLumberjack

final class CovidInfoClient: CovidClient {
    
    // MARK: - Properties
    
    private let baseUrl: URL

    // MARK: - Initialization

    init(baseUrl: URL) {
        // Set Properties
        self.baseUrl = baseUrl
    }

    // MARK: - Public API
    
    func fetchData<T>(from endpoint: APIEndpoint, _ completion: @escaping (Result<T, APIError>) -> Void) where T : Decodable, T : Encodable {
        
        sendRequest(with: request(for: endpoint), completion)
    }

    func fetchCovidInfo(_ completion: @escaping (Result<[CovidInfoModel], APIError>) -> Void) {
        // Create and Initiate Data Task
        fetchData(from: .covidInfo, completion)
    }
    
    func refreshInfo(_ completion: @escaping (Result<[CovidInfoModel], APIError>) -> Void) {
        // Create and Initiate Data Task
        fetchData(from: .refreshInfo, completion)
    }
    
    func fetchCovidDetailInfo(with url: String, _ completion: @escaping (Result<CountryCovidDetailModel, APIError>) -> Void) {
        // Create and Initiate Data Task
        fetchData(from: .countryDetail(url), completion)
    }
    
    // MARK: - Helper Methods

    private func request(for endpoint: APIEndpoint) -> URLRequest? {
        // Create URL
        guard let url = URL(string: "\(baseUrl)\(endpoint.path)") else {
            return nil
        }

        // Create Request
        var request = URLRequest(url: url)

        // Configure Request
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        return request
    }
    
    func sendRequest<T: Codable>(with request: URLRequest?,
                     _ completion: @escaping (Result<T, APIError>) -> Void) {
        guard let request = request else {
            completion(.failure(.requestFailed))
            return
        }
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let data = data {
                do {
                    // Initialize JSON Decoder
                    let decoder = JSONDecoder()

                    // Configure JSON Decoder
                    decoder.dateDecodingStrategy = .iso8601
                    decoder.keyDecodingStrategy = .convertFromSnakeCase

                    // Decode JSON Response
                    let countriesCovidInfo = try decoder.decode(T.self, from: data)

                    // Invoke Handler
                    DispatchQueue.main.async {
                        completion(.success(countriesCovidInfo))
                    }
                } catch {
                    // Invoke Handler
                    print(error)
                    completion(.failure(.invalidResponse))
                }

            } else {
                // Invoke Handler
                completion(.failure(.requestFailed))
                
                if let error = error {
//                    DDLogError("Unable to Fetch Episodes \(error)")
                } else {
//                    DDLogError("Unable to Fetch Episodes")
                }
            }
        }.resume()
    }


}
