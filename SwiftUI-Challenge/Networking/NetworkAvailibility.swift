//
//  NetworkStatus.swift
//  SwiftUI-Challenge
//
//  Created by Mohadese Raoufi on 5/4/22.
//

import Foundation
import Network



class NetworkAvailibility {
    
    enum NetworkStatus {
        case connected
        case disconnected
    }
    
    // MARK: - Properties
    public static var status: NetworkStatus {
        let monitor = NWPathMonitor()
        var stat: NetworkStatus = .disconnected
        monitor.pathUpdateHandler = { path in
            if path.status == .satisfied {
                stat = .connected
            } else {
                stat = .disconnected
            }
        }
        return stat
    }
    
}
