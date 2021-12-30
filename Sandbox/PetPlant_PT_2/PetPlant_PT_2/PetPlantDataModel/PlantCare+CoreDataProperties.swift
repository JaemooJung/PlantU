//
//  PlantCare+CoreDataProperties.swift
//  PetPlant_PT_2
//
//  Created by JaemooJung on 2021/01/10.
//
//

import Foundation
import CoreData


extension PlantCare {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PlantCare> {
        return NSFetchRequest<PlantCare>(entityName: "PlantCare")
    }

    @NSManaged public var careDate: Date?
    @NSManaged public var changeLocation: Bool
    @NSManaged public var nutrition: Bool
    @NSManaged public var pruning: Bool
    @NSManaged public var repotting: Bool
    @NSManaged public var watering: Bool
    @NSManaged public var plant: Plant?

}

extension PlantCare : Identifiable {

}
