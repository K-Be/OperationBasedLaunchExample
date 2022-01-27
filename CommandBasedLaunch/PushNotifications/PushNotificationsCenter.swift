//
//  PushNotificationsCenter.swift
//  CommandBasedLaunch
//
//  Created by Andrew Romanov on 27.01.2022.
//

import Foundation
import UIKit

protocol PushNotificationsListener: AnyObject {
    func pushNotificationsCenter(_ sender: PushNotificationsCenter, gotNotification notification: PushNotification)
}


class PushNotificationsCenter {
    private var listeners = [PushNotificationsListener]()
    private var allow = false

    func subscribeToNotifications(_ listener: PushNotificationsListener, inViewController viewController: UIViewController, withCompletion completion: @escaping (_ result: Bool) -> Void) {
        self.showSubscribeDialog(in: viewController) { allow in
            self.allow = allow
            if allow {
                self.listeners.append(listener)
            }
            completion(allow)
        }
    }

    func scheduleNotification(_ notification: PushNotification, deadline: DispatchTime) {
        if self.allow {
            DispatchQueue.main.asyncAfter(deadline: deadline) {
                self.listeners.forEach {
                    $0.pushNotificationsCenter(self, gotNotification: notification)
                }
            }
        }
    }

    private func showSubscribeDialog(in viewController: UIViewController, withCompletion completion: @escaping (_ allow: Bool) -> Void) {
        let alertController = UIAlertController(title: "Получение уведомлений",
                                                message: "Разрешить получение уведомлений?",
                                                preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Да",
                                                style: .default,
                                                handler: { _ in
            completion(true)
        }))
        alertController.addAction(UIAlertAction(title: "Нет",
                                                style: .cancel,
                                                handler: { _ in
            completion(false)
        }))
        viewController.present(alertController, animated: true, completion: nil)
    }

}



