//
//  Entity+CoreDataProperties.swift
//  PetPlant_Prototype
//
//  Created by JaemooJung on 2021/01/06.
//
//

import Foundation
import CoreData


extension Entity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Entity> {
        return NSFetchRequest<Entity>(entityName: "Entity")
    }

    @NSManaged public var id: String?
    @NSManaged public var plantName: String?
    @NSManaged public var lastWateredDate: Date?
    @NSManaged public var waterInterval: Int16
    @NSManaged public var species: String?
    @NSManaged public var registeredDate: Date?
    @NSManaged public var birthDate: Date?
    @NSManaged public var profilePhoto: String?

}

extension Entity : Identifiable {

}
