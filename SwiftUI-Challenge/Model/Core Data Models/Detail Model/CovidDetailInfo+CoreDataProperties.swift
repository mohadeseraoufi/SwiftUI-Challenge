//
//  CovidDetailInfo+CoreDataProperties.swift
//  SwiftUI-Challenge
//
//  Created by Mohadese Raoufi on 5/5/22.
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
    @NSManaged public var country: String
    @NSManaged public var historyDataURL: String
    @NSManaged public var sourceURL: String
    @NSManaged public var lastUpdatedAtApify: String
    @NSManaged public var lastUpdatedAtSource: String
    @NSManaged public var readMe: String
    @NSManaged public var infectedByRegion: NSSet?

}

// MARK: Generated accessors for infectedByRegion
extension CovidDetailInfo {

    @objc(addInfectedByRegionObject:)
    @NSManaged public func addToInfectedByRegion(_ value: RegionInfection)

    @objc(removeInfectedByRegionObject:)
    @NSManaged public func removeFromInfectedByRegion(_ value: RegionInfection)

    @objc(addInfectedByRegion:)
    @NSManaged public func addToInfectedByRegion(_ values: NSSet)

    @objc(removeInfectedByRegion:)
    @NSManaged public func removeFromInfectedByRegion(_ values: NSSet)

}

extension CovidDetailInfo : Identifiable {

}
