//
//  Notifications.swift
//  ToDo_List
//
//  Created by Konstantine Tsirgvava on 31.08.24.
//

import Foundation

enum Notifications: String {
    
    case taskUpdated = "taskUpdated"
    
    var notificationName: Notification.Name {
        return Notification.Name(self.rawValue)
    }
}
