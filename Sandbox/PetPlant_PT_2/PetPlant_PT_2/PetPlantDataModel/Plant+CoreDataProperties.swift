//
//  Plant+CoreDataProperties.swift
//  PetPlant_PT_2
//
//  Created by JaemooJung on 2021/01/10.
//
//

import Foundation
import CoreData


extension Plant {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Plant> {
        return NSFetchRequest<Plant>(entityName: "Plant")
    }

    @NSManaged public var birthDate: Date?
    @NSManaged public var lastWateredDate: Date?
    @NSManaged public var plantName: String?
    @NSManaged public var profilePhoto: String?
    @NSManaged public var registeredDate: Date?
    @NSManaged public var species: String?
    @NSManaged public var waterInterval: Int16
    @NSManaged public var journals: NSSet?
    @NSManaged public var plantCares: NSSet?

}

// MARK: Generated accessors for journals
extension Plant {

    @objc(addJournalsObject:)
    @NSManaged public func addToJournals(_ value: Journal)

    @objc(removeJournalsObject:)
    @NSManaged public func removeFromJournals(_ value: Journal)

    @objc(addJournals:)
    @NSManaged public func addToJournals(_ values: NSSet)

    @objc(removeJournals:)
    @NSManaged public func removeFromJournals(_ values: NSSet)

}

// MARK: Generated accessors for plantCares
extension Plant {

    @objc(addPlantCaresObject:)
    @NSManaged public func addToPlantCares(_ value: PlantCare)

    @objc(removePlantCaresObject:)
    @NSManaged public func removeFromPlantCares(_ value: PlantCare)

    @objc(addPlantCares:)
    @NSManaged public func addToPlantCares(_ values: NSSet)

    @objc(removePlantCares:)
    @NSManaged public func removeFromPlantCares(_ values: NSSet)

}

extension Plant : Identifiable {

}
