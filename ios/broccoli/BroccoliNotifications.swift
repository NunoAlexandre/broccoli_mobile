//
//  NotificationsPermissionRequest.swift
//  broccoli
//
//  Created by Nuno on 20/05/2017.
//  Copyright © 2017 nunoalexandre. All rights reserved.
//

import Foundation
import UserNotifications
import UIKit

class BroccoliNotifications {
    private let application : UIApplication!
    
    init(application : UIApplication) {
        self.application = application
    }
    
    func setup() {
        if #available(iOS 10, *) {
            UNUserNotificationCenter.current()
                .requestAuthorization(options: [.alert, .badge, .sound]) { (granted, error) in
                if granted { self.didGrantPermission() }
            }
        }
        else {
            let settings = UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
            application.registerUserNotificationSettings(settings)
        }
    }
    
    private func didGrantPermission() {
        AddDayNotification(notifyAt: AddDayNotification.defaultDate())
            .schedule()
    }
}
