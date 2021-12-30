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

func stringToDateYYYYMMDD(dateInStringFormat string:String ) -> Date? {
    

    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd"
    
    if let date = dateFormatter.date(from: string) {
        return date
    } else {
        return nil
    }

    
}
