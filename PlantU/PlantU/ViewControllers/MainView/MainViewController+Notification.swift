//
//  MainViewController+Notification.swift
//  PetPlantRealmDemo
//
//  Created by JaemooJung on 2021/01/19.
//

import Foundation
import UIKit
import UserNotifications

extension MainViewController {
    
    func setWaterAlarm() {
        guard let fetchedPlants = plants  else { return }
        for plant in fetchedPlants {
            guard plant.isWaterAlarmOn else { return }
            guard let waterInterval = plant.waterInterval else {return}
            // 현재 캘린더 받아옴
            let calendar = Calendar.current
            // lastWateredDate -> DateComponents
            var lastWateredDateComponents = calendar.dateComponents([.hour, .minute, .day, .month, .year], from: plant.lastWateredDate!)
            // waterAlarmTime -> DateComponents
            let alarmTimeComponents = calendar.dateComponents([.hour, .minute], from: plant.waterAlarmTime!)
            // 알람 시간을 유저가 설정한대로 지정...
            lastWateredDateComponents.hour = alarmTimeComponents.hour
            lastWateredDateComponents.minute = alarmTimeComponents.minute
            // LastWateredDate에다가 waterInterval을 더해서 알람 날짜 지정
            let formattedLastWateredDate = calendar.date(from: lastWateredDateComponents)
            let waterAlarmDateAndDate = calendar.date(byAdding: .day, value: Int(waterInterval)!, to: formattedLastWateredDate!)

            // 알람 센터에 넣어주기 위해 DateComponents로 변환...
            let waterAlarmDateComponents = calendar.dateComponents([.hour, .minute, .day, .month, .year], from: waterAlarmDateAndDate!)
            
            // 알람 지정
            makeNotification(alarmDateAndTime: waterAlarmDateComponents, plantName: plant.plantName!)
            
            print("\(plant) \(waterAlarmDateComponents.day) \(waterAlarmDateComponents.hour) 알람 설정 완료")
        }
        
        
        //todo
        //물주는 날짜가 지났을 때 주는 알람 설정....
        
    }
    
    
    
    func makeNotification(alarmDateAndTime: DateComponents, plantName: String) {
        let center = UNUserNotificationCenter.current()
        
        center.requestAuthorization(options: [.alert, .sound]) { (granted, error) in
        }
        
        center.removeAllPendingNotificationRequests()
        
        let content = UNMutableNotificationContent()
        content.title = "물주기 알람"
        content.body = "\(plantName)에게 물을 줄 시간이에요 !!"
        
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: alarmDateAndTime, repeats: false)
        
        let uuidString = UUID().uuidString
        let request = UNNotificationRequest(identifier: uuidString, content: content, trigger: trigger)
        
        center.add(request) { (error) in
            print(error as Any)
        }
        
        
        
    }
    
    
    
}
