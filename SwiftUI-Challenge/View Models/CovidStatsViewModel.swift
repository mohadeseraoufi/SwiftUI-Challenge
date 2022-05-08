//
//  CovidStatsViewModel.swift
//  SwiftUI-Challenge
//
//  Created by Mohadese Raoufi on 5/4/22.
//

import Foundation
import SwiftUI
import CoreData

class CovidStatsViewModel: ObservableObject {
    
    //MARK: - Properties
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @Published var countriesInfo:[CountryCovidInfoViewModel] = []
    private var apiClient = EnvironmentSettings.apiClient
    private lazy var covidStatsDataProvider: CovidStatsCDProvider = {
        let provider = CovidStatsCDProvider(with: appDelegate.coreDataStack)
        return provider
    }()
    
    
    func getCovidStatsInfo(completion: @escaping ([CountryCovidInfoViewModel]) -> Void) {
        
        if Reachability.isConnectedToNetwork() {
            // Get info from web
            apiClient.fetchCovidInfo { result in
                switch result {
                case .success(let covidInfo):
                    self.countriesInfo = covidInfo.map({ CountryCovidInfoViewModel(covidInfo: $0) })
                    self.cacheCovidInfo()
                    completion(self.countriesInfo)
                case .failure(let error):
                    completion([])
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
                    completion(self.countriesInfo)
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


