//
//  NotificationManager.swift
//  DailyDo
//
//  Created by Soo Jang on 2023/08/25.
//

import Foundation
import UserNotifications

final class NotificationManager {
    
    
    func refreshNotificationFrom(memoEntityList: [MemoEntity]) {
        let userNotificationCenter = UNUserNotificationCenter.current()
        userNotificationCenter.removeAllPendingNotificationRequests()
        
        for memo in memoEntityList {
            let cycle = Int(memo.cycle + 1)
            guard let hour = memo.firstTime?.getIntHour() else { return }
            guard let minute = memo.firstTime?.getIntMinute() else { return }
            guard let memoText = memo.memo else { return }
            let identifier = memo.identifier
            scheduleNotification(cycle: cycle, hour: hour, minute: minute, memo: memoText, identifier: identifier)
        }
    }
        
    //MARK: Schedule Notification
    func scheduleNotification(cycle: Int, hour: Int, minute: Int, memo: String, identifier: URL) {
        var dateComponents = DateComponents()
        for i in stride(from: cycle, through: 30, by: cycle) {
            dateComponents.day = i + 1
            dateComponents.hour = hour
            dateComponents.minute = minute
            
            let content = UNMutableNotificationContent()
            content.title = "\(CycleText.days[cycle]) 해야 할 일이에요!"
            content.body = memo
            content.sound = .default
            
            let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
            
            let request = UNNotificationRequest(identifier: "\(identifier)\(i)", content: content, trigger: trigger)
            
            UNUserNotificationCenter.current().add(request) { (error) in
                if let error = error {
                    print("알림 예약 실패: \(error)")
                } else {
                    print("알림이 성공적으로 예약되었습니다.")
                }
            }
        }
    }
    
    func removeNotification(cycle: Int,identifier: URL) {
        let userNotificationCenter = UNUserNotificationCenter.current()
        var removingID: [String] = []
        for i in stride(from: cycle, through: 30, by: cycle) {
            removingID.append("\(identifier)\(i)")
        }
        userNotificationCenter.removePendingNotificationRequests(withIdentifiers: removingID)
    }
    
    
    func requestNotification() {
        let userNotificationCenter = UNUserNotificationCenter.current()
        userNotificationCenter.requestAuthorization(options: [.alert, .badge, .sound]) { (granted, error) in
            if granted {
                print("알림 권한이 허용되었습니다.")
            } else {
                print("알림 권한이 거부되었습니다.")
            }
        }
    }
}
