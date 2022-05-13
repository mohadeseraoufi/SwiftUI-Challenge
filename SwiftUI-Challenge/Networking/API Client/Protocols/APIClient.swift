//
//  APIClient.swift
//  Cocoacasts
//
//  Created by Bart Jacobs on 20/01/2020.
//  Copyright © 2020 Code Foundry. All rights reserved.
//

import Foundation

protocol APIClient: AnyObject {
    
    func fetchData<T: Codable>(from endpoint: APIEndpoint, _ completion: @escaping (Result<T, APIError>) -> Void)
}


// Segregated Interface to be more flexible in case in future we want to add other client.

protocol CovidClient: APIClient{
    
    func fetchCovidInfo(_ completion: @escaping (Result<[CovidInfoModel], APIError>) -> Void)
    func fetchCovidDetailInfo(with url: String, _ completion: @escaping (Result<CountryCovidDetailModel, APIError>) -> Void)
    func refreshInfo(_ completion: @escaping (Result<[CovidInfoModel], APIError>) -> Void)
}
