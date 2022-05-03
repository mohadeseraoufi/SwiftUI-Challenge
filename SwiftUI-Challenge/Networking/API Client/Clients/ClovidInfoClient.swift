//
//  APIClient.swift
//  Cocoacasts
//
//  Created by Bart Jacobs on 06/11/2019.
//  Copyright © 2019 Code Foundry. All rights reserved.
//

import Foundation
//import CocoaLumberjack

final class CovidInfoClient: APIClient {

    // MARK: - Properties

    // MARK: -
    
    private let baseUrl: URL

    // MARK: - Initialization

    init(baseUrl: URL) {
        // Set Properties
        self.baseUrl = baseUrl
    }

    // MARK: - Public API

    func fetchCovidInfo(_ completion: @escaping (Result<[CovidInfoModel], APIError>) -> Void) {
        // Create and Initiate Data Task
        URLSession.shared.dataTask(with: request(for: .covidInfo)) { (data, response, error) in
            if let data = data {
                do {
                    // Initialize JSON Decoder
                    let decoder = JSONDecoder()

                    // Configure JSON Decoder
                    decoder.dateDecodingStrategy = .iso8601
                    decoder.keyDecodingStrategy = .convertFromSnakeCase

                    // Decode JSON Response
                    let countriesCovidInfo = try decoder.decode([CovidInfoModel].self, from: data)

                    // Invoke Handler
                    completion(.success(countriesCovidInfo))
                } catch {
                    // Invoke Handler
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

    // MARK: - Helper Methods

    private func request(for endpoint: APIEndpoint) -> URLRequest {
        // Create URL
        let url = baseUrl.appendingPathComponent(endpoint.path)

        // Create Request
        var request = URLRequest(url: url)

        // Configure Request
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        return request
    }
    
    func fetchCovidDetailInfo(with url: String, _ completion: @escaping (Result<CountryCovidDetailModel, APIError>) -> Void) {
        // Create and Initiate Data Task
        URLSession.shared.dataTask(with: request(for: .countryDetail(url))) { (data, response, error) in
            if let data = data {
                do {
                    // Initialize JSON Decoder
                    let decoder = JSONDecoder()

                    // Configure JSON Decoder
                    decoder.dateDecodingStrategy = .iso8601
                    decoder.keyDecodingStrategy = .convertFromSnakeCase

                    // Decode JSON Response
                    let covidInfoDetail = try decoder.decode(CountryCovidDetailModel.self, from: data)

                    // Invoke Handler
                    completion(.success(covidInfoDetail))
                } catch {
                    // Invoke Handler
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
