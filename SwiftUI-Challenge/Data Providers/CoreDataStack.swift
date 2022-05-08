//
//  CovidStatsDataProvider.swift
//  SwiftUI-Challenge
//
//  Created by Mohadese Raoufi on 5/7/22.
//

import Foundation
import CoreData


// MARK: - Core Data Stack

/**
 Core Data stack setup including history processing.
 */
class CoreDataStack {
    
    // MARK: - Core Data stack
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "SwiftUI_Challenge")
        container.loadPersistentStores { _, error in
            print(container.persistentStoreDescriptions.first?.url)
            
            if let error = error as NSError? {
                // You should add your own error handling code here.
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()
    
    // MARK: - Core Data Saving support
    
    func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // The context couldn't be saved.
                // You should add your own error handling here.
                let nserror = error as NSError
                print(nserror)
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    
}

