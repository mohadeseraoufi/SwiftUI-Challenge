//
//  CovidStatsDataProvider.swift
//  SwiftUI-Challenge
//
//  Created by Mohadese Raoufi on 5/7/22.
//

import Foundation
import CoreData

class CovidStatsCDProvider {
    
    var coreDataStack: CoreDataStack

    init(with coreDataStack: CoreDataStack) {
        self.coreDataStack = coreDataStack
    }
    
    func fetchCovidInfo(_ completion: @escaping (Result<[CovidInfo], CoreDataError>) -> Void) {
        let fetchRequest:NSFetchRequest<CovidInfo> = CovidInfo.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "country", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        do {
            let covidStats:[CovidInfo] = try coreDataStack.persistentContainer.viewContext.fetch(fetchRequest)
            print(covidStats)
            completion(.success(covidStats))
        } catch {
            print(error)
            completion(.failure(.fetchFailed))
        }
    }
    
    
    func saveCovidInfo(countriesCovidInfo: [CountryCovidInfoViewModel]) {
        deleteAllData("CovidInfo")
        countriesCovidInfo.forEach { covidInfo in
            let cachedCovidInfo = CovidInfo(context: coreDataStack.persistentContainer.viewContext)
            cachedCovidInfo.country = covidInfo.country
            cachedCovidInfo.infected = Int32(covidInfo.infected ?? 0)
            cachedCovidInfo.tested = Int32(covidInfo.tested ?? 0)
            cachedCovidInfo.recovered = Int32(covidInfo.recovered ?? 0)
            cachedCovidInfo.deceased = Int32(covidInfo.deceased ?? 0)
            cachedCovidInfo.moreDataURL = covidInfo.moreDataURL
            cachedCovidInfo.historyDataURL = covidInfo.historyDataURL
            cachedCovidInfo.sourceURL = covidInfo.sourceURL
            cachedCovidInfo.lastUpdatedApify = covidInfo.lastUpdatedApify
            cachedCovidInfo.lastUpdatedSource = covidInfo.lastUpdatedSource ?? ""
        }
        coreDataStack.saveContext()
    }
    
    func deleteAllData(_ entity:String) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
        fetchRequest.returnsObjectsAsFaults = false
        do {
            let results = try coreDataStack.persistentContainer.viewContext.fetch(fetchRequest)
            for object in results {
                guard let objectData = object as? NSManagedObject else {continue}
                coreDataStack.persistentContainer.viewContext.delete(objectData)
            }
        } catch let error {
            print("Detele all data in \(entity) error :", error)
        }
    }
    
}
