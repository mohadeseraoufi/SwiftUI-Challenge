//
//  CovidStatsViewModel.swift
//  SwiftUI-Challenge
//
//  Created by Mohadese Raoufi on 5/4/22.
//

import Foundation

struct CovidStatsViewModel {
    
    //MARK: - Properties
    private var countriesInfo:[CountryCovidInfoViewModel] = []
    private var apiClient = EnvironmentSettings.apiClient
    
    
    func getCovidStatsInfo() {
        
        if NetworkAvailibility.status == .connected {
            // Get info from web
            apiClient.fetchCovidInfo { result in
                switch result {
                case .success(let covidInfo):
                    print(covidInfo)
                case .failure(let error):
                    fatalError(error.localizedDescription)
                }
            }
        } else {
            // Get info from cache
        }
        
    }
    
}
