//
//  NotificationAlertService.swift
//  Sunblock
//
//  Created by Vikram on 10/03/2019.
//  Copyright © 2019 Shortcut. All rights reserved.
//

import UIKit

class NotificationAlertService {
    static let current = NotificationAlertService()
    
    private(set) var isAnimating = false
    
    func presentNotificationAlert() {
        let alertView       = NotificationAlertView()
        alertView.delegate  = self
        let window          = UIApplication.shared.keyWindow!
        
        window.addSubview(alertView)
        alertView.animateAlert()
    }
}

extension NotificationAlertService: NotificationAlertViewDelegate {
    func notificationDidAccept() {
        UserNotificationService.current.requestPermission { (_) in
            SettingsUtility.hasAskedForNotificationPermission = true
        }
    }
    
    func notificationDidDecline() {
        print("Did Decline")
    }
}
