//
//  NotificationsManager.swift
//  NotificationsManager
//
//  Created by Aidan Pendlebury on 28/07/2021.
//

import Foundation
import UserNotifications

class NotificationManager {
    
    static let shared = NotificationManager()
    private let center = UNUserNotificationCenter.current()
    
    private init() {}
    
    
    func requestPermission() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
            if let error = error {
                print(error.localizedDescription)
            }
        }
    }

    
    func scheduleNewNotification(id: String, logRecordId: String, notificationText: String, notificationCategory: NotificationCategory, date: DateComponents) {
        center.getNotificationSettings { settings in
            guard (settings.authorizationStatus == .authorized) else { return }
            let content = UNMutableNotificationContent()
            content.title = notificationText
            content.sound = UNNotificationSound.default
            content.userInfo = ["LOG_RECORD_ID": logRecordId]
            content.categoryIdentifier = notificationCategory.rawValue

            let trigger = UNCalendarNotificationTrigger(dateMatching: date, repeats: false)
            
            let request = UNNotificationRequest(identifier: id, content: content, trigger: trigger)
            
            self.center.add(request)
        }
    }
      

    func cancelSpecificNotifications(ids: [String]) {
        center.removePendingNotificationRequests(withIdentifiers: ids)
    }
    
    
    
    func cancelAllNotificaitons() {
        center.removeAllPendingNotificationRequests()
    }
    
    // To be deleted - diagnostics only
    func printAllNotifications() {
        print("Should be getting notifications now")
        center.getPendingNotificationRequests() { notifications in
            for notification in notifications {
                print("\(notification.identifier): \(notification.content)")
            }
        }
    }
    
}

enum NotificationCategory: String {
    case shortBreak
    case longBreak
    case session
}
