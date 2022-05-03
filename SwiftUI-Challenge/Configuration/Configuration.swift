//
//  Configuration.swift
//  Cocoacasts
//
//  Created by Bart Jacobs on 29/03/2019.
//  Copyright © 2019 Code Foundry. All rights reserved.
//

import Foundation

enum Configuration: String {
    
    // MARK: - Configurations
    
    case debug
    case release
    
    // MARK: - Current Configuration
    
    static let current: Configuration = {
        // Read Value From Info.plist
        guard let value = Bundle.main.infoDictionary?["CONFIGURATION"] as? String else {
            fatalError("No Configuration Found")
        }
        
        // Extract Configuration
        guard let rawValue = value.split(separator: "/").first else {
            fatalError("Invalid Configuration")
        }
        
        // Create Configuration
        guard let configuration = Configuration(rawValue: rawValue.lowercased()) else {
            fatalError("Invalid Configuration")
        }
        
        return configuration
    }()
    
}
