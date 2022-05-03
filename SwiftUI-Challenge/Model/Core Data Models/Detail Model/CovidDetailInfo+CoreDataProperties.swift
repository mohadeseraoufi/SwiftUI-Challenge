//
//  CovidDetailInfo+CoreDataProperties.swift
//  SwiftUI-Challenge
//
//  Created by Mohadese Raoufi on 5/4/22.
//
//

import Foundation
import CoreData


extension CovidDetailInfo {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CovidDetailInfo> {
        return NSFetchRequest<CovidDetailInfo>(entityName: "CovidDetailInfo")
    }

    @NSManaged public var infected: Int32
    @NSManaged public var tested: Int32
    @NSManaged public var recovered: Int32
    @NSManaged public var deceased: Int32
    @NSManaged public var country: String?
    @NSManaged public var historyDataURL: String?
    @NSManaged public var sourceURL: String?
    @NSManaged public var lastUpdatedAtApify: String?
    @NSManaged public var lastUpdatedAtSource: String?
    @NSManaged public var readMe: String?
    @NSManaged public var infectedByRegion: RegionInfection?

}

extension CovidDetailInfo : Identifiable {

}
