//
//  CovidStatsDataProvider.swift
//  SwiftUI-Challenge
//
//  Created by Mohadese Raoufi on 5/7/22.
//

import Foundation
import CoreData

class CovidDetailCDProvider {
    
    var persistentContainer: NSPersistentContainer
    
    init(with persistentContainer: NSPersistentContainer) {
        self.persistentContainer = persistentContainer
    }
    
    func fetchCovidDetailInfo(with url: String, _ completion: @escaping (Result<CovidDetailInfo, CoreDataError>) -> Void) {

        let request = CovidDetailInfo.fetchRequest()
        
        // create an NSPredicate to get the instance you want to make change
        let predicate = NSPredicate(format: "name = %@", url)
        request.predicate = predicate
        
        do {
            let tasks = try persistentContainer.viewContext.fetch(request)
            completion(.success(tasks.first!))
        } catch let error {
            print(error.localizedDescription)
            completion(.failure(.fetchFailed))
        }
        
    }
    
    
    func saveCovidInfo(covidDetailInfo: CovidStatsDetailViewModel) {
        let covidInfo = CovidDetailInfo(context: persistentContainer.viewContext)
        covidInfo.infected = Int32(covidDetailInfo.infected)
        covidInfo.tested = Int32(covidDetailInfo.tested)
        covidInfo.recovered = Int32(covidDetailInfo.recovered)
        covidInfo.deceased = Int32(covidDetailInfo.deceased)
        covidInfo.country = covidDetailInfo.country
        covidInfo.historyDataURL = covidDetailInfo.historyDataURL
        covidInfo.sourceURL = covidDetailInfo.sourceURL
        covidInfo.lastUpdatedAtApify = covidDetailInfo.lastUpdatedAtApify
        covidInfo.lastUpdatedAtSource = covidDetailInfo.lastUpdatedAtSource
        covidInfo.readMe = covidDetailInfo.readMe
        covidInfo.infectedByRegion?.addingObjects(from: covidDetailInfo.infectedByRegion)
        save()
    }
    
    func save() {
        do {
            try persistentContainer.viewContext.save()
        } catch {
            fatalError()
        }
    }
    
    
}
