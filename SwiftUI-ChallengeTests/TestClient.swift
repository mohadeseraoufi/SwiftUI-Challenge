//
//  TestClient.swift
//  SwiftUI-Challenge
//
//  Created by Mohadese Raoufi on 5/3/22.
//

import Foundation
@testable import SwiftUI_Challenge

final class CovidTestClient: APIClient {

    // MARK: - Properties

    // MARK: - Public API

    func fetchCovidInfo(_ completion: @escaping (Result<[CovidInfoModel], APIError>) -> Void) {
        // Load json mock from bundle
        guard let jsonFileURL = Bundle.main.url(forResource: "covid-allcountries", withExtension: "json") else {fatalError("File not found") }
        do {
            let jsonData = try Data(contentsOf: jsonFileURL)
            do {
                // Initialize JSON Decoder
                let decoder = JSONDecoder()

                // Configure JSON Decoder
                decoder.dateDecodingStrategy = .iso8601
                decoder.keyDecodingStrategy = .convertFromSnakeCase

                // Decode JSON Response
                let countriesCovidInfo = try decoder.decode([CovidInfoModel].self, from: jsonData)

                // Invoke Handler
                completion(.success(countriesCovidInfo))
            } catch {
                // Invoke Handler
                completion(.failure(.invalidResponse))
            }
        } catch {
            fatalError("Data conversion failed")
        }
    }

    // MARK: - Helper Methods

    func fetchCovidDetailInfo(with url: String, _ completion: @escaping (Result<CountryCovidDetailModel, APIError>) -> Void) {
        // Create and Initiate Data Task
        guard let jsonFileURL = Bundle.main.url(forResource: "covid-country-detail", withExtension: "json") else {fatalError("File not found") }
        do {
            let jsonData = try Data(contentsOf: jsonFileURL)
            do {
                // Initialize JSON Decoder
                let decoder = JSONDecoder()

                // Configure JSON Decoder
                decoder.dateDecodingStrategy = .iso8601
                decoder.keyDecodingStrategy = .convertFromSnakeCase

                // Decode JSON Response
                let countriesCovidInfo = try decoder.decode(CountryCovidDetailModel.self, from: jsonData)

                // Invoke Handler
                completion(.success(countriesCovidInfo))
            } catch {
                // Invoke Handler
                completion(.failure(.invalidResponse))
            }
        } catch {
            fatalError("Data conversion failed")
        }
    }

}
