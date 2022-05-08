//
//  CovidStatsViewModel.swift
//  SwiftUI-Challenge
//
//  Created by Mohadese Raoufi on 5/4/22.
//

import Foundation

class CovidStatsViewModel {
    
    //MARK: - Properties
    private var appDelegate: AppDelegate!
    private var countriesInfo:[CountryCovidInfoViewModel] = []
    private var apiClient = EnvironmentSettings.apiClient
    private lazy var covidStatsDataProvider: CovidStatsCDProvider = {
        let provider = CovidStatsCDProvider(with: appDelegate.coreDataStack.persistentContainer)
        return provider
    }()
    
    init(appDelegate: AppDelegate) {
        self.appDelegate = appDelegate
    }
    
    func getCovidStatsInfo() {
        
        if NetworkAvailibility.status == .connected {
            // Get info from web
            apiClient.fetchCovidInfo { result in
                switch result {
                case .success(let covidInfo):
                    print(covidInfo)
                    self.countriesInfo = covidInfo.map({ CountryCovidInfoViewModel(covidInfo: $0) })
                    self.cacheCovidInfo()
                case .failure(let error):
                    fatalError(error.localizedDescription)
                }
            }
        } else {
            // Get info from cache
            covidStatsDataProvider.fetchCovidInfo { result in
                switch result {
                case .success(let covidInfo):
                    print(covidInfo)
                    self.countriesInfo = covidInfo.map({ CountryCovidInfoViewModel(covidInfo: $0) })
                case .failure(let error):
                    fatalError(error.localizedDescription)
                }
            }
        }
        
    }
    
    func cacheCovidInfo() {
        covidStatsDataProvider.saveCovidInfo(countriesCovidInfo: countriesInfo)
    }
    
    
    
}


