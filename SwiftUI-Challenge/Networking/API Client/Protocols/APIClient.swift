//
//  APIClient.swift
//  Cocoacasts
//
//  Created by Bart Jacobs on 20/01/2020.
//  Copyright © 2020 Code Foundry. All rights reserved.
//

import Foundation

internal protocol APIClient: AnyObject {

    func fetchCovidInfo(_ completion: @escaping (Result<[CovidInfoModel], APIError>) -> Void)
    func fetchCovidDetailInfo(with url: String, _ completion: @escaping (Result<CountryCovidDetailModel, APIError>) -> Void)
    func refreshInfo(_ completion: @escaping (Result<[CovidInfoModel], APIError>) -> Void)

}
