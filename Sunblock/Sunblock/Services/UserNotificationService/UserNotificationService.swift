//
//  UserNotificationService.swift
//  Sunblock
//
//  Created by Suthananth Arulanatham on 23.05.2018.
//  Copyright © 2018 Shortcut. All rights reserved.
//

import UIKit
import UserNotifications

class UserNotificationService: NSObject{
    static let current = UserNotificationService()

    private override init(){
        super.init()
        UNUserNotificationCenter.current().delegate = self
    }

    func requestPermission(completion: @escaping (Bool) -> Void){
        UNUserNotificationCenter.current().requestAuthorization(options: [.sound, .alert]) { (granted, error) in
            if granted{
                print("Granted for user notification")

                completion(true)
            }else{
                completion(false)
            }
        }
    }

    func hasPendingNotificationRequests(completion: @escaping (Bool)->Void){
        UNUserNotificationCenter.current().getPendingNotificationRequests { (requests) in
            completion(requests.count != 0)
        }
    }

    func removeAllPendingRequests(){
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
    }


    func scheduleNotification(with timeInterval: TimeInterval){
        requestPermission { (granted) in
            if granted{

                let center = UNUserNotificationCenter.current()
                center.removeAllPendingNotificationRequests()

                // Create content
                let content = UNMutableNotificationContent()
                content.title = "Sunblock"
                content.body  = "It is time to reapply sun screen!"
                content.sound = UNNotificationSound.default()

                // create trigger
                let trigger = UNTimeIntervalNotificationTrigger(timeInterval: timeInterval, repeats: false)
                let identifier = "SunblockNotifications"
                let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
                center.add(request, withCompletionHandler: { (error) in
                    if error != nil {
                        print("Error")
                    }
                })

            }else{
                // Present alert.
                print("Not granted")
                AlertService.presentAlert(with: "Please enable notification in the settings app", title: "Notifications are disabled")
            }
        }
    }
}


extension UserNotificationService: UNUserNotificationCenterDelegate{

    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {

        print("alert will be shown!")
    }
}
