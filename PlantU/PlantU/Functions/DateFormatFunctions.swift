//
//  DataFormatFunctions.swift
//  PetPlantRealmDemo
//
//  Created by JaemooJung on 2021/01/15.
//

import Foundation

func dateToStringYYYYMMDD(date:Date) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd"
    
    return dateFormatter.string(from: date)
}

func dateToStringKr(date: Date) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.locale = Locale(identifier: "ko")
    dateFormatter.dateFormat = "MMM dd"
    
    return dateFormatter.string(from: date)
}

func stringToDateYYYYMMDD(dateInStringFormat string:String ) -> Date? {
    

    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd"
    
    if let date = dateFormatter.date(from: string) {
        return date
    } else {
        return nil
    }
    
    
}


func dayAfter(daysToAdd: Int, from baseDate: Date) -> Date {
    var dateComponents = DateComponents()
    dateComponents.day = daysToAdd
    return Calendar.current.date(byAdding: dateComponents, to: baseDate)!
}

func daysBetween(firstDate: Date, secondDate: Date) -> String {
    
    let caledar = Calendar.current
    
    let date1 = caledar.startOfDay(for: firstDate)
    let date2 = caledar.startOfDay(for: secondDate)
    
    let components = caledar.dateComponents([.day], from: date1, to: date2)
    return String(components.day!)
    
}
