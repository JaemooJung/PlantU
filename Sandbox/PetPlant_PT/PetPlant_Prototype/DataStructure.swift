//
//  DataStructure.swift
//  PetPlant_Prototype
//
//  Created by JaemooJung on 2021/01/04.
//

import Foundation
import UIKit

struct Plant {
    var plantName:String
    var birthDate:String
    var registeredDate:String
    var species:String
    var waterInterval:Int?
    var wateredDate:String
    var isWaterAlarmOn:Bool
    var profilePhoto:UIImage?
    
    init() {
        self.plantName = ""
        self.birthDate = ""
        self.registeredDate = ""
        self.species = ""
        self.wateredDate = ""
        self.waterInterval = nil
        self.profilePhoto = nil
        self.isWaterAlarmOn = true
    }
}

struct Journal {
    let plant:Plant
    var writtenDate:DateComponents = DateComponents()
    var journalName:String? = ""
    var journalContent:String = ""
    var journalPhoto:UIImage?
    var journalAction:Dictionary<String, Bool>? = [:]
    var emotionalState:emotinalStateTypes?
    
    enum emotinalStateTypes {
        case good, normal, bad
    }
    
}


//let white = Plant(plantName: "White", birthDate: "2020/10/10", registeredDate: "2020/12/31", species: "Stuki", waterInterval: 30, wateredDate: "2020/12/31", properTemperature: 25.5)
//let blue = Plant(plantName: "Blue", birthDate: DateComponents(year: 2020, month: 11,day: 2), registeredDate: DateComponents(year:2020, month: 11, day: 15), species: "Gardenia", waterInterval: 7, wateredDate: DateComponents(year:2020, month: 12, day: 19), properTemperature: 23.0)
//
//let red = Plant(plantName: "Red", birthDate: DateComponents(year: 2020, month: 12,day: 10), registeredDate: DateComponents(year:2020, month: 12, day: 20), species: "Rose", waterInterval: 14, wateredDate: DateComponents(year:2020, month: 12, day: 28), properTemperature: 24.0)


//let day1Journal = Journal(plant: white, journalContent: "첫 번째 일기, 올해 마지막 날", journalAction: ["watering":true], emotionalState: .good)

//let day2Journal = Journal(plant: white, journalContent: "두 번째 일기, 새해 첫 날", journalAction: ["watering":true, "pruning":true], emotionalState: .normal)
//let day3Journal = Journal(plant: red, journalContent: "세 번째 일기, 새해 둘쩨 날", journalAction: ["watering":true, "pruning":true], emotionalState: .bad)
