//
//  CountryCovidDetailInfo.swift
//  SwiftUI-Challenge
//
//  Created by Mohadese Raoufi on 5/3/22.
//

import Foundation


// MARK: - CovidInfo
struct CountryCovidDetailModel: Codable {
    let infected, tested, recovered, deceased: Int
    let infectedByRegion: [InfectedByRegion]
    let country: String
    let historyDataURL, sourceURL: String
    let lastUpdatedAtApify, lastUpdatedAtSource: String
    let readMe: String

    enum CodingKeys: String, CodingKey {
        case infected, tested, recovered, deceased, infectedByRegion, country
        case sourceURL = "sourceUrl"
        case historyDataURL = "historyData"
        case lastUpdatedAtApify, lastUpdatedAtSource, readMe
    }
}

// MARK: - InfectedByRegion
struct InfectedByRegion: Codable {
    let region, isoCode: String
    let infected, recovered, deceased: Int
}
