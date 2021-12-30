//
//  DataModel.swift
//  PetPlantRealmDemo
//
//  Created by JaemooJung on 2021/01/15.
//

import Foundation
import RealmSwift


class Plant: Object {
    @objc dynamic var _id: String?
    @objc dynamic var plantName:String?
    @objc dynamic var birthDate: Date?
    @objc dynamic var registeredDate: Date?
    @objc dynamic var species: String?
    @objc dynamic var lastWateredDate: Date?
    @objc dynamic var isWaterAlarmOn: Bool = false
    @objc dynamic var waterAlarmTime: Date?
    @objc dynamic var waterInterval: String?
    
    
    
    
    @objc dynamic var profilePhotoURL: String?
    
    let journals = List<Journal>()
    
    override static func primaryKey() -> String? {
        return "_id"
    }
}

class Journal: Object {
    @objc dynamic var _id: String?
    @objc dynamic var writtenDate:Date?
    @objc dynamic var journalTitle:String?
    @objc dynamic var journalContent:String?
    @objc dynamic var journalPhotoURL:String?
    
    @objc dynamic var plantCare:PlantCare? = nil
    @objc dynamic var emotionalState:EmotionalState? = nil
    dynamic var plant = LinkingObjects(fromType: Plant.self, property: "journals")
    
    override static func primaryKey() -> String? {
        return "_id"
    }
}

class EmotionalState: Object {
    @objc dynamic var emotionDate:Date?
    @objc dynamic var joyful:Bool = false
    @objc dynamic var calm:Bool = false
    @objc dynamic var anxious:Bool = false
    @objc dynamic var sad:Bool = false
    @objc dynamic var angry:Bool = false
    let journal = LinkingObjects(fromType: Journal.self, property: "emotionalState")
}

class PlantCare: Object {
    
    @objc dynamic var careDate:Date?
    @objc dynamic var watering:Bool = false
    @objc dynamic var nutrition:Bool = false
    @objc dynamic var pruning:Bool = false
    @objc dynamic var repotting:Bool = false
    @objc dynamic var changeLocation:Bool = false
    let journal = LinkingObjects(fromType: Journal.self, property: "plantCare")
    
    
}
