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
}
