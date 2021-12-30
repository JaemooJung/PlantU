//
//  EmotionalStateAndPlantCare.swift
//  PetPlantRealmDemo
//
//  Created by JaemooJung on 2021/01/17.
//

import Foundation


func getEmotionalStateOfThisJournal(journal: Journal) -> String {
    if journal.emotionalState!.joyful {
        return "기쁨"
    } else if journal.emotionalState!.calm {
        return "평온"
    } else if journal.emotionalState!.anxious {
        return "걱정"
    } else if journal.emotionalState!.sad {
        return "슬픔"
    } else if journal.emotionalState!.angry {
        return "분노"
    } else {
        return ""
    }
}


func getPlantCaresOfThisJournal(journal: Journal) -> [String] {
    let plantCare = journal.plantCare
    var plantCareArray:[String] = []
    if plantCare!.watering {
        plantCareArray.append("물주기")
    }
    if plantCare!.nutrition {
        plantCareArray.append("영양제")
    }
    if plantCare!.pruning {
        plantCareArray.append("가지치기")
    }
    if plantCare!.changeLocation {
        plantCareArray.append("자리옮기기")
    }
    if plantCare!.repotting {
        plantCareArray.append("화분갈이")
    }
    
    return plantCareArray
    
}
