//
//  Environment.swift
//  Cocoacasts
//
//  Created by Bart Jacobs on 29/03/2019.
//  Copyright © 2019 Code Foundry. All rights reserved.
//

import Foundation

enum EnvironmentSettings: String {
    
    // MARK: - Environments
    
    case production
    case development

    // MARK: - Current Environment
    
    static let current: EnvironmentSettings = {
        // Read Value From Info.plist
        guard let value = Bundle.main.infoDictionary?["BUILD_ENVIRONMENT"] as? String else {
            fatalError("No Configuration Found")
        }
        
        // Create Environment
        guard let environment = EnvironmentSettings(rawValue: value.lowercased()) else {
            fatalError("Invalid Environment")
        }
        
        return environment
    }()

    // MARK: - Base URL
    
    private static var baseUrl: URL {
        switch current {
        case .production:
            return URL(string: "https://api.apify.com/v2/")!
        case .development:
            return URL(string: "https://api.apify.com/dev/")!
        }
    }
    
    
    // MARK: - API Client

    static var apiClient: APIClient {
        switch current {
        case .development:
            // Create Mock Client
            let mockClient = MockClient()

            // Configure Endpoints
            mockClient.setResponse(.success(MockAPI.CovidInfo.success), for: .covidInfo)
            mockClient.setResponse(.failure(.requestFailed), for: .countryDetail(MockAPI.CovidInfoDetail.success))

            return mockClient
        default:
            return CovidInfoClient(baseUrl: baseUrl)
        }
    }
    
}

#warning("Urls should change with .json file")
private enum MockAPI {
    
    enum CovidInfo {
        
        static let success = URL(string: "https://api.apify.com/v2/datasets/ga7yLcJHGazqTHcpt/items")!
        
    }
    enum CovidInfoDetail {
        
        static let success = "https://api.apify.com/v2/key-value-stores/pp4Wo2slUJ78ZnaAi/records/LATEST?disableRedirect=true"
        
    }
}
