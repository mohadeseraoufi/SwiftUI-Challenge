//
//  CountryCovidInfoViewModel.swift
//  SwiftUI-Challenge
//
//  Created by Mohadese Raoufi on 5/4/22.
//

import Foundation

struct CountryCovidInfoViewModel {
    
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
        self.tested = getIntValueFrom(info: covidInfo.tested)
        self.recovered = getIntValueFrom(info: covidInfo.recovered)
        self.deceased = getIntValueFrom(info: covidInfo.deceased)
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
    
    /// Since Apify api returns multiple value types for a key we only need the integer represeting the number
    func getIntValueFrom(info:DeceasedUnion) -> Int? {
        switch info {
        case .enumeration(_):
            return nil
        case .integer(let int):
            return int
        case .null:
            return nil
        }
    }
    
}
