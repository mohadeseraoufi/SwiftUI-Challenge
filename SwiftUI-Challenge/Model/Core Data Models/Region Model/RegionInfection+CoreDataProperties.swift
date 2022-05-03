//
//  RegionInfection+CoreDataProperties.swift
//  SwiftUI-Challenge
//
//  Created by Mohadese Raoufi on 5/4/22.
//
//

import Foundation
import CoreData


extension RegionInfection {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<RegionInfection> {
        return NSFetchRequest<RegionInfection>(entityName: "RegionInfection")
    }

    @NSManaged public var region: String?
    @NSManaged public var isoCode: String?
    @NSManaged public var infected: Int32
    @NSManaged public var recovered: Int32
    @NSManaged public var deceased: Int32
    @NSManaged public var country: CovidDetailInfo?

}

extension RegionInfection : Identifiable {

}
