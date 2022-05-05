//
//  CovidStatsDetailViewModel.swift
//  SwiftUI-Challenge
//
//  Created by Mohadese Raoufi on 5/4/22.
//

import Foundation

struct CovidStatsDetailViewModel {
    
    //MARK: - Properties

    let infected, tested, recovered, deceased: Int
    var infectedByRegion: [InfectedByRegion]
    let country: String
    let historyDataURL, sourceURL: String
    let lastUpdatedAtApify, lastUpdatedAtSource: String
    let readMe: String
    
    // Reading from Online Model
    init(covidInfo: CountryCovidDetailModel) {
        self.infected = covidInfo.infected
        self.tested = covidInfo.tested
        self.recovered = covidInfo.recovered
        self.infectedByRegion = covidInfo.infectedByRegion
        self.deceased = covidInfo.deceased
        self.country = covidInfo.country
        self.historyDataURL = covidInfo.historyDataURL
        self.sourceURL = covidInfo.sourceURL
        self.lastUpdatedAtApify = covidInfo.lastUpdatedAtApify
        self.lastUpdatedAtSource = covidInfo.lastUpdatedAtSource
        self.readMe = covidInfo.readMe
    }
    
    // Reading from Core Data Model
    init(covidInfo: CovidDetailInfo) {
        self.infected = Int(covidInfo.infected)
        self.tested = Int(covidInfo.tested)
        self.recovered = Int(covidInfo.recovered)
        self.deceased = Int(covidInfo.deceased)
        self.infectedByRegion = []
        self.country = covidInfo.country
        self.historyDataURL = covidInfo.historyDataURL
        self.sourceURL = covidInfo.sourceURL
        self.lastUpdatedAtApify = covidInfo.lastUpdatedAtApify
        self.lastUpdatedAtSource = covidInfo.lastUpdatedAtSource
        self.readMe = covidInfo.readMe
        covidInfo.infectedByRegion?.allObjects.forEach({ region in
            if let regionInfo = region as? RegionInfection {
                infectedByRegion.append(InfectedByRegion(regionInfo: regionInfo))
            }
        })
        
    }
}
