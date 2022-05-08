//
//  CountryCovidInfoViewModel.swift
//  SwiftUI-Challenge
//
//  Created by Mohadese Raoufi on 5/4/22.
//

import Foundation

class CountryCovidInfoViewModel: Identifiable {
    
    // MARK: - Properties
    let infected: Int?
    let tested, recovered, deceased: Int?
    let country: String
    let moreDataURL, historyDataURL: String
    let sourceURL: String?
    let lastUpdatedApify: String
    let lastUpdatedSource: String?
    
    init(covidInfo: CovidInfoModel) {
        self.infected = covidInfo.infected
        self.tested = covidInfo.tested.intValue()
        self.recovered = covidInfo.recovered.intValue()
        self.deceased = covidInfo.deceased.intValue()
        self.country = covidInfo.country
        self.moreDataURL = covidInfo.moreDataURL
        self.historyDataURL = covidInfo.historyDataURL
        self.sourceURL = covidInfo.sourceURL
        self.lastUpdatedApify = covidInfo.lastUpdatedApify
        self.lastUpdatedSource = covidInfo.lastUpdatedSource
    }
    
    init(covidInfo: CovidInfo) {
        self.infected = Int(covidInfo.infected)
        self.tested = Int(covidInfo.tested)
        self.recovered = Int(covidInfo.recovered)
        self.deceased = Int(covidInfo.deceased)
        self.country = covidInfo.country
        self.moreDataURL = covidInfo.moreDataURL
        self.historyDataURL = covidInfo.historyDataURL
        self.sourceURL = covidInfo.sourceURL
        self.lastUpdatedApify = covidInfo.lastUpdatedApify
        self.lastUpdatedSource = covidInfo.lastUpdatedSource
    }
    
    
    
}
