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
    @Published var detailInfo:CovidStatsDetailViewModel? = nil
    private var apiClient = EnvironmentSettings.apiClient
    private lazy var covidStatsDataProvider: CovidStatsCDProvider = {
        let provider = CovidStatsCDProvider(with: appDelegate.coreDataStack)
        return provider
    }()
    private lazy var covidDetailDataProvider: CovidDetailCDProvider = {
        let provider = CovidDetailCDProvider(with: appDelegate.coreDataStack)
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
    
    
    func getCountryDetailInfo(with url: String, completion: @escaping (CovidStatsDetailViewModel?) -> Void) {
        
        print(url)
        if Reachability.isConnectedToNetwork() {
            // Get info from web
            apiClient.fetchCovidDetailInfo(with:url) { result in
                
                switch result {
                case .success(let covidInfo):
                    self.detailInfo = CovidStatsDetailViewModel(covidInfo: covidInfo)
                    self.cacheCovidInfo()
                    completion(self.detailInfo!)
                case .failure(let error):
                    completion(nil)
                    fatalError(error.localizedDescription)
                }
            }
        } else {
            // Get info from cache
//            covidDetailDataProvider.fetchCovidDetailInfo(with:url) { result in
//                switch result {
//                case .success(let covidInfo):
//                    print(covidInfo)
//                    self.detailInfo = CovidStatsDetailViewModel(covidInfo: covidInfo)
//                    completion(self.detailInfo!)
//                case .failure(let error):
//                    completion(nil)
//                    fatalError(error.localizedDescription)
//                }
//            }
        }
        
    }
    
    func cacheCovidDetailInfo() {
        covidDetailDataProvider.saveCovidInfo(covidDetailInfo: detailInfo!)
    }
    
    
}


