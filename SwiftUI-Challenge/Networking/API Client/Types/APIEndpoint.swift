//
//  APIEndpoint.swift
//  Cocoacasts
//
//  Created by Bart Jacobs on 20/01/2020.
//  Copyright © 2020 Code Foundry. All rights reserved.
//

import Foundation

internal enum APIEndpoint: Hashable, CaseIterable {
    
    static var allCases: [APIEndpoint] = []
    
    // MARK: - Cases
    
    case covidInfo
    case countryDetail(String)
    
    // MARK: - Properties
    
    var path: String {
        switch self {
            case .covidInfo:
                return "datasets/ga7yLcJHGazqTHcpt/items"
            case .countryDetail(let address):
                return address
        }
    }
    
}
