//
//  AddDayNotification.swift
//  broccoli
//
//  Created by Nuno on 20/05/2017.
//  Copyright © 2017 nunoalexandre. All rights reserved.
//

import Foundation

class AddDayNotification {
    private let notification : DLNotification
    
    
    init(notifyAt : Date) {
       notification = DLNotification( identifier: "addDayNotification",
                                  alertTitle: "Hi Broccoli!",
                                  alertBody: "Don't forget to add your day :)",
                                  date: notifyAt,
                                  repeats: .Daily)
    }
    
    func schedule() {
        _ = DLNotificationScheduler().scheduleNotification(notification: notification)
    }
    
    class func defaultDate() -> Date {
        return Calendar.current.startOfDay(for: Date()).addingTimeInterval(-10800)
    }
}
