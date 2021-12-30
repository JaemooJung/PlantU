//
//  Journal+CoreDataProperties.swift
//  PetPlant_PT_2
//
//  Created by JaemooJung on 2021/01/10.
//
//

import Foundation
import CoreData


extension Journal {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Journal> {
        return NSFetchRequest<Journal>(entityName: "Journal")
    }

    @NSManaged public var emotionalState: String?
    @NSManaged public var journalContent: String?
    @NSManaged public var journalPhoto: String?
    @NSManaged public var journalTitle: String?
    @NSManaged public var writtenDate: Date?
    @NSManaged public var plant: Plant?

}

extension Journal : Identifiable {

}
