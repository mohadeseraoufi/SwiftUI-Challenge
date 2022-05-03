//
//  CovidInfoModel.swift
//  SwiftUI-Challenge
//
//  Created by Mohadese Raoufi on 5/3/22.
//

import Foundation

// MARK: - CovidInfoElement
struct CovidInfoModel: Codable {
    let infected: Int?
    let tested, recovered, deceased: String
    let country: String
    let moreDataURL, historyDataURL: String
    let sourceURL: String?
    let lastUpdatedApify: String
    let lastUpdatedSource: String?

    enum CodingKeys: String, CodingKey {
        case infected, tested, recovered, deceased, country
        case sourceURL = "sourceUrl"
        case moreDataURL = "moreData"
        case historyDataURL = "historyData"
        case lastUpdatedApify, lastUpdatedSource
    }
}
