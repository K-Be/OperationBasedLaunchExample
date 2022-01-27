//
//  PushNotification.swift
//  CommandBasedLaunch
//
//  Created by Andrew Romanov on 27.01.2022.
//

import Foundation

struct PushNotification {
    enum NotificationType: String {
        case advertising
        case personal
    }

    let type: NotificationType
    let parameter: String
    let message: String
}

