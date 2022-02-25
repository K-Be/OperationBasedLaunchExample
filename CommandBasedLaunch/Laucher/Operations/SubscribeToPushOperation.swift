//
//  SubscribeToPushOperation.swift
//  CommandBasedLaunch
//
//  Created by Andrew Romanov on 27.01.2022.
//

import Foundation

class SubscribeToPushOperation: AsynchronousOperation {

    let sceneDelegate: SceneDelegate

    internal init(sceneDelegate: SceneDelegate) {
        self.sceneDelegate = sceneDelegate
    }

    override func main() {
        super.main()
        guard !isCancelled else {
            self.finish()
            return
        }
        self.syncOnMain {
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) {
                self.sceneDelegate.askPushNotifications {
                    self.finish()
                }
            }
        }
    }
}
