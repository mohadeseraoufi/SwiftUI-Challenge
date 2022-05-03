//
//  CovidInfo+CoreDataProperties.swift
//  SwiftUI-Challenge
//
//  Created by Mohadese Raoufi on 5/4/22.
//
//

import Foundation
import CoreData


extension CovidInfo {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CovidInfo> {
        return NSFetchRequest<CovidInfo>(entityName: "CovidInfo")
    }

    @NSManaged public var infected: Int32
    @NSManaged public var tested: Int32
    @NSManaged public var recovered: Int32
    @NSManaged public var deceased: Int32
    @NSManaged public var country: String?
    @NSManaged public var moreDataURL: String?
    @NSManaged public var historyDataURL: String?
    @NSManaged public var sourceURL: String?
    @NSManaged public var lastUpdatedApify: String?
    @NSManaged public var lastUpdatedSource: String?

}

extension CovidInfo : Identifiable {

}
