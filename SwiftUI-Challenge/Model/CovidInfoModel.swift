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
    let tested, recovered, deceased: DeceasedUnion
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

enum DeceasedUnion: Codable {
    case enumeration(DeceasedEnum)
    case integer(Int)
    case null

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Int.self) {
            self = .integer(x)
            return
        }
        if let x = try? container.decode(DeceasedEnum.self) {
            self = .enumeration(x)
            return
        }
        if container.decodeNil() {
            self = .null
            return
        }
        throw DecodingError.typeMismatch(DeceasedUnion.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for DeceasedUnion"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .enumeration(let x):
            try container.encode(x)
        case .integer(let x):
            try container.encode(x)
        case .null:
            try container.encodeNil()
        }
    }
    
    /// Since Apify api returns multiple value types for a key we only need the integer represeting the number
    func intValue() -> Int? {
        switch self {
        case .enumeration(_):
            return nil
        case .integer(let int):
            return int
        case .null:
            return nil
        }
    }
}

enum DeceasedEnum: String, Codable {
    case na = "NA"
}

