//
//  APIError.swift
//  Cocoacasts
//
//  Created by Bart Jacobs on 20/01/2020.
//  Copyright © 2020 Code Foundry. All rights reserved.
//

import Foundation

internal enum APIError: Error {
    
    // MARK: - Cases
    
    case requestFailed
    case invalidResponse
    case requestNotFound
    
}

internal enum CoreDataError: Error {
    
    // MARK: - Cases
    
    case fetchFailed
    
}
