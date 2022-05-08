//
//  CovidStatsDataProvider.swift
//  SwiftUI-Challenge
//
//  Created by Mohadese Raoufi on 5/7/22.
//

import Foundation
import CoreData

class CovidStatsCDProvider {
    
    var persistentContainer: NSPersistentContainer
    
    init(with persistentContainer: NSPersistentContainer) {
        self.persistentContainer = persistentContainer
    }
    
    func fetchCovidInfo(_ completion: @escaping (Result<[CovidInfo], CoreDataError>) -> Void) {
        let fetchRequest:NSFetchRequest<CovidInfo> = CovidInfo.fetchRequest()
        do {
            let covidStats:[CovidInfo] = try persistentContainer.viewContext.fetch(fetchRequest)
            completion(.success(covidStats))
        } catch {
            completion(.failure(.fetchFailed))
        }
    }
    
    
    func saveCovidInfo(countriesCovidInfo: [CountryCovidInfoViewModel]) {
        countriesCovidInfo.forEach { covidInfo in
            let chachedCovidInfo = CovidInfo(context: persistentContainer.viewContext)
            chachedCovidInfo.infected = Int32(covidInfo.infected ?? 0)
            chachedCovidInfo.tested = Int32(covidInfo.tested ?? 0)
            chachedCovidInfo.recovered = Int32(covidInfo.recovered ?? 0)
            chachedCovidInfo.deceased = Int32(covidInfo.deceased ?? 0)
            chachedCovidInfo.moreDataURL = covidInfo.moreDataURL
            chachedCovidInfo.historyDataURL = covidInfo.historyDataURL
            chachedCovidInfo.sourceURL = covidInfo.sourceURL
            chachedCovidInfo.lastUpdatedApify = covidInfo.lastUpdatedApify
            chachedCovidInfo.lastUpdatedSource = covidInfo.lastUpdatedSource ?? ""
            save()
        }
    }
    
    func save() {
        do {
            try persistentContainer.viewContext.save()
        } catch {
            fatalError()
        }
    }
    
    
}
