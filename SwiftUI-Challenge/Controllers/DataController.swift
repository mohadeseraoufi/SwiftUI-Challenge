//
//  DataController.swift
//  SwiftUI-Challenge
//
//  Created by Mohadese Raoufi on 5/5/22.
//

import Foundation
import CoreData
import SwiftUI

class DataController: ObservableObject {
    
    let container = NSPersistentContainer(name: "SwiftUI_Challenge")
    
    init() {
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Core Data failed to load: \(error.localizedDescription)")
            }
        }
    }
}
